# Variables globales del proyecto para la infraestructura de Tomcat en AWS
# Estas variables se utilizan en todos los módulos y ambientes (dev/qa/prod)

variable "project_name" {
  description = "Nombre del proyecto para etiquetado y organización de recursos"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
}

variable "public_subnets_cidr" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad para distribuir los recursos"
  type        = list(string)
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para el servidor Tomcat"
  type        = string
}

variable "key_name" {
  description = "Nombre de la clave SSH para acceder a las instancias"
  type        = string
}

variable "tomcat_version" {
  description = "Versión de Apache Tomcat a instalar"
  type        = string
}

variable "jvm_heap_size" {
  description = "Tamaño máximo del heap de la JVM (ej. 2048m)"
  type        = string
}

variable "jvm_perm_size" {
  description = "Tamaño de la memoria permanente de la JVM (ej. 256m)"
  type        = string
}

variable "jvm_max_perm_size" {
  description = "Tamaño máximo de la memoria permanente de la JVM (ej. 512m)"
  type        = string
}

variable "jvm_gc_algorithm" {
  description = "Algoritmo de garbage collection a usar (ej. UseG1GC)"
  type        = string
}
}

variable "min_instance_count" {
  description = "Número mínimo de instancias en el Auto Scaling Group"
  type        = number
}

variable "max_instance_count" {
  description = "Número máximo de instancias en el Auto Scaling Group"
  type        = number
}

variable "desired_instance_count" {
  description = "Número deseado de instancias en el Auto Scaling Group"
  type        = number
}
}

variable "alb_ssl_certificate_arn" {
  description = "ARN del certificado SSL para el Application Load Balancer"
  type        = string
}

variable "tags" {
  description = "Etiquetas adicionales para todos los recursos"
  type        = map(string)
  default     = {}
}

variable "ssh_cidr_blocks" {
  description = "Bloques CIDR permitidos para acceso SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "http_cidr_blocks" {
  description = "Bloques CIDR permitidos para acceso HTTP/HTTPS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "database_username" {
  description = "Usuario para la base de datos RDS"
  type        = string
}

variable "database_password" {
  description = "Contraseña para la base de datos RDS"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "Nombre de la base de datos RDS"
  type        = string
}

variable "database_instance_class" {
  description = "Clase de instancia para la base de datos RDS"
  type        = string
}