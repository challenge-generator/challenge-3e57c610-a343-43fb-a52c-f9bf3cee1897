terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudposse = {
      source  = "cloudposse/tomcat/aws"
      version = "0.10.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = var.resource_owner
    }
  }

  skip_credentials_validation = false
  skip_requesting_account_id  = false
  skip_metadata_api_check     = false
}

data "aws_caller_identity" "current" {}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

module "network_infra" {
  source = "./modules/network_infra"

  environment           = var.environment
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  enable_vpn_gateway   = var.enable_vpn_gateway
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Module      = "network"
  }
}

module "tomcat_server" {
  source = "./modules/tomcat_server"

  environment           = var.environment
  project_name          = var.project_name
  ami_id                = data.aws_ami.ubuntu.id
  instance_type         = var.instance_type
  key_name              = var.key_name
  subnet_id             = module.network_infra.private_subnet_ids[0]
  vpc_security_group_id = module.tomcat_server.security_group_id

  tomcat_version           = var.tomcat_version
  tomcat_port              = var.tomcat_port
  tomcat_ssl_enabled       = var.tomcat_ssl_enabled
  jvm_heap_size            = var.jvm_heap_size
  jvm_gc_type              = var.jvm_gc_type
  jvm_metaspace_size       = var.jvm_metaspace_size
  jvm_thread_stack_size    = var.jvm_thread_stack_size
  jvm_gc_log_enabled       = var.jvm_gc_log_enabled
  jvm_gc_log_rotation_size = var.jvm_gc_log_rotation_size
  jvm_gc_log_max_files     = var.jvm_gc_log_max_files
  tomcat_max_threads       = var.tomcat_max_threads
  tomcat_min_spare_threads = var.tomcat_min_spare_threads
  tomcat_connection_timeout = var.tomcat_connection_timeout
  tomcat_accept_count      = var.tomcat_accept_count
  tomcat_enable_compression = var.tomcat_enable_compression
  tomcat_compressible_mime_types = var.tomcat_compressible_mime_types
  tomcat_compression_min_size = var.tomcat_compression_min_size

  enable_monitoring           = var.enable_monitoring
  cloudwatch_logs_retention_days = var.cloudwatch_logs_retention_days
  enable_detailed_monitoring  = var.enable_detailed_monitoring

  root_volume_size           = var.root_volume_size
  root_volume_type           = var.root_volume_type
  root_volume_encrypted      = var.root_volume_encrypted

  enable_auto_scaling        = var.enable_auto_scaling
  min_instances              = var.min_instances
  max_instances              = var.max_instances
  desired_capacity           = var.desired_capacity
  scaling_cpu_threshold_high = var.scaling_cpu_threshold_high
  scaling_cpu_threshold_low  = var.scaling_cpu_threshold_low
  scaling_cooldown           = var.scaling_cooldown

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Module      = "tomcat"
  }
}

resource "aws_lb" "tomcat" {
  name               = "${var.project_name}-tomcat-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.network_infra.alb_security_group_id]
  subnets            = module.network_infra.public_subnet_ids

  enable_deletion_protection = var.enable_alb_deletion_protection

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Name        = "${var.project_name}-tomcat-alb-${var.environment}"
  }
}

resource "aws_lb_target_group" "tomcat" {
  name     = "${var.project_name}-tomcat-tg-${var.environment}"
  port     = var.tomcat_port
  protocol = "HTTP"
  vpc_id   = module.network_infra.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200"
  }

  stickiness {
    enabled = true
    type    = "lb_cookie"
    cookie_duration = 86400
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.tomcat.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tomcat.arn
  }
}

resource "aws_lb_listener" "https" {
  count             = var.tomcat_ssl_enabled ? 1 : 0
  load_balancer_arn = aws_lb.tomcat.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tomcat.arn
  }
}

resource "aws_lb_listener_rule" "static_content" {
  count = var.enable_static_content_cache ? 1 : 0

  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tomcat.arn
  }

  condition {
    path_pattern {
      values = ["/*.css", "/*.js", "/*.jpg", "/*.png", "/*.ico", "/*.woff*"]
    }
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  count = var.enable_auto_scaling ? 1 : 0

  autoscaling_group_id = module.tomcat_server.autoscaling_group_id
  lb_target_group_arn  = aws_lb_target_group.tomcat.arn
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  count = var.enable_monitoring ? 1 : 0

  alarm_name          = "${var.project_name}-tomcat-cpu-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.alarm_cpu_threshold
  alarm_description   = "CPU utilization above threshold for Tomcat server"
  alarm_actions       = [aws_sns_topic.tomcat_alerts.arn]

  dimensions = {
    AutoScalingGroupName = var.enable_auto_scaling ? module.tomcat_server.autoscaling_group_name : ""
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  count = var.enable_monitoring && var.enable_auto_scaling ? 1 : 0

  alarm_name          = "${var.project_name}-tomcat-cpu-low-${var.environment}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.alarm_cpu_low_threshold
  alarm_description   = "CPU utilization below threshold for Tomcat server scale-in"
  alarm_actions       = [aws_sns_topic.tomcat_alerts.arn]

  dimensions = {
    AutoScalingGroupName = module.tomcat_server.autoscaling_group_name
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  count = var.enable_monitoring ? 1 : 0

  alarm_name          = "${var.project_name}-tomcat-memory-high-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.alarm_memory_threshold
  alarm_description   = "Memory utilization above threshold for Tomcat server"
  alarm_actions       = [aws_sns_topic.tomcat_alerts.arn]

  dimensions = {
    InstanceId = var.enable_auto_scaling ? "" : module.tomcat_server.instance_id
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_sns_topic" "tomcat_alerts" {
  name = "${var.project_name}-tomcat-alerts-${var.environment}"

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_sns_topic_subscription" "tomcat_alerts_email" {
  count = var.alert_email != "" ? 1 : 0

  topic_arn = aws_sns_topic.tomcat_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_kms_key" "ebs_encryption" {
  description             = "KMS key for EBS encryption on Tomcat servers"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-policy"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow EC2 to use this key"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "kms:ViaService" = "ec2.${var.aws_region}.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Name        = "${var.project_name}-ebs-kms-${var.environment}"
  }
}

resource "aws_kms_alias" "ebs_encryption" {
  name          = "alias/${var.project_name}-ebs-${var.environment}"
  target_key_id = aws_kms_key.ebs_encryption.key_id
}

resource "aws_s3_bucket" "tomcat_logs" {
  bucket = "${var.project_name}-tomcat-logs-${var.environment}-${data.aws_caller_identity.current.account_id}"

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tomcat_logs" {
  bucket = aws_s3_bucket.tomcat_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "tomcat_logs" {
  bucket = aws_s3_bucket.tomcat_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_role" "ec2_ssm_role" {
  name = "${var.project_name}-ec2-ssm-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "${var.project_name}-ec2-ssm-profile-${var.environment}"
  role = aws_iam_role.ec2_ssm_role.name

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}