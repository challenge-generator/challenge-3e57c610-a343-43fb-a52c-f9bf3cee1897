environment               = "qa"
project_name             = "banca-digital"
owner                    = "cloud-ops-team"

# Configuración de red para QA
vpc_cidr                 = "10.1.0.0/16"
public_subnet_cidrs      = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs     = ["10.1.10.0/24", "10.1.20.0/24"]
availability_zones      = ["us-east-1a", "us-east-1b"]

# Configuración de instancia EC2 para QA
instance_type            = "t3.large"
instance_count           = 2
ami_id                   = "ami-0c55b159cbfafe1f0"
key_name                 = "banca-digital-qa-key"

# Configuración de Tomcat para QA
tomcat_version           = "9.0.85"
tomcat_port              = 8080
tomcat_ssl_enabled       = true
tomcat_ssl_port          = 8443
max_threads              = 300
min_spare_threads        = 50
connection_timeout       = 20000
max_connections          = 10000

# Configuración de JVM optimizada para QA
jvm_heap_min             = "1024m"
jvm_heap_max             = "2048m"
jvm_metaspacesize        = "256m"
jvm_max_metaspacesize    = "512m"
jvm_gc_algorithm         = "G1GC"
jvm_gc_log_enabled       = true
jvm_gc_log_size          = "100m"
jvm_gc_log_max_files     = 10
jvm_extra_opts           = "-XX:+UseStringDeduplication -XX:+ParallelRefProcEnabled -XX:+UnlockCommercialFeatures -XX:+FlightRecorder"
jvm_agents_enabled       = true
jvm_heap_dump_enabled    = true
jvm_heap_dump_path       = "/opt/tomcat/logs"

# Configuración de seguridad para QA
allowed_ssh_cidr         = ["10.1.0.0/16", "10.2.0.0/16"]
allowed_app_cidr         = ["10.1.0.0/16", "10.2.0.0/16"]
ssh_port                 = 22
enable_monitoring        = true
enable_logging           = true
enable_audit_logging     = true

# Configuración de almacenamiento
root_volume_size         = 30
data_volume_size         = 50
volume_type              = "gp3"

# Configuración de costos y etiquetas
cost_center              = "CC-QA-001"
enable_cost_alerts       = true
budget_limit_monthly     = 500.0
cost_alert_threshold     = 0.80

# Configuración de alta disponibilidad para QA
enable_health_checks     = true
health_check_interval    = 15
health_check_timeout     = 5
health_check_unhealthy   = 2
enable_load_balancer     = true
lb_deletion_protection   = false