# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Como saber que terminaste

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Cloud Ops, Especialidad Analista, Seniority Senior

### Brecha de conocimiento
Implementa soluciones de servidores de aplicación como Apache Tomcat o IBM Websphere de manera integral y realiza optimizaciones sobre las mismas

### Misión / candidato
Candidato con experiencia en infraestructura y operaciones en la nube, enfocado en optimización de servidores

### Reto
- Tema: Manejo de Middleware
- Seniority: senior-l2
- Tipo: practical
- Título: Optimización de Servidores de Aplicación
- Tiempo estimado: 15 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración Inicial del Servidor — objetivo: Configurar un servidor de aplicación Apache Tomcat para soportar las cargas de trabajo actuales. — entregable (NO resolver): Servidor de aplicación configurado y operativo.
- Fase 2: Optimización del Rendimiento — objetivo: Optimizar el rendimiento del servidor de aplicación para manejar cargas de trabajo más altas. — entregable (NO resolver): Servidor de aplicación optimizado con mejoras documentadas.
- Fase 3: Evaluación y Documentación — objetivo: Evaluar el rendimiento del servidor optimizado y documentar las mejoras realizadas. — entregable (NO resolver): Informe de evaluación y documentación de mejoras.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: variables.tf ===
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

// === ARCHIVO: providers.tf ===
# Configuración de proveedores para Terraform
# Define los proveedores necesarios y sus versiones

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudposse = {
      source  = "cloudposse/cloudposse"
      version = ">= 0.1.0"
    }
  }
}

# Proveedor AWS principal
provider "aws" {
  region = var.region
  default_tags {
    tags = merge(
      {
        "Project"     = var.project_name
        "Environment" = var.environment
        "ManagedBy"   = "Terraform"
      },
      var.tags
    )
  }
}

# Configuración adicional para módulos de CloudPosse
provider "cloudposse" {
  # Este proveedor no requiere configuración adicional
  # pero se declara para asegurar compatibilidad con módulos
}

# Backend remoto para el estado de Terraform (se configurará en backend.tf)
# La configuración específica del backend se define en backend.tf
# para permitir diferentes configuraciones por ambiente

# Validación de variables para asegurar configuraciones válidas
locals {
  validate_instance_type = contains([
    "t3.micro", "t3.small", "t3.medium", "t3.large", 
    "m5.large", "m5.xlarge", "m5.2xlarge", "c5.large", "c5.xlarge"
  ], var.instance_type) ? true : "Tipo de instancia no soportado"

  validate_tomcat_version = contains([
    "8.5.60", "9.0.45", "10.0.8"
  ], var.tomcat_version) ? true : "Versión de Tomcat no soportada"

  validate_environment = contains([
    "dev", "qa", "prod"
  ], var.environment) ? true : "Ambiente no válido"

  # Validación de CIDR blocks
  validate_vpc_cidr = can(cidrhost(var.vpc_cidr, 0)) ? true : "CIDR de VPC no válido"
  validate_public_subnets = alltrue([
    for cidr in var.public_subnets_cidr : can(cidrhost(cidr, 0))
  ]) ? true : "Uno o más CIDR de subredes públicas no válidos"
  validate_private_subnets = alltrue([
    for cidr in var.private_subnets_cidr : can(cidrhost(cidr, 0))
  ]) ? true : "Uno o más CIDR de subredes privadas no válidos"

  # Validación de zonas de disponibilidad
  validate_az_count = length(var.availability_zones) >= 2 ? true : "Se requieren al menos 2 zonas de disponibilidad"
}

// === ARCHIVO: modules/tomcat_server/variables.tf ===
# Variables específicas para el módulo de servidor Tomcat
# Configuración detallada del servidor de aplicación y sus recursos asociados

variable "project_name" {
  description = "Nombre del proyecto para etiquetado"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará el servidor"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs de subredes para el Auto Scaling Group"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Lista de IDs de security groups para las instancias"
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

variable "alb_arn" {
  description = "ARN del Application Load Balancer"
  type        = string
}

variable "alb_target_group_arn" {
  description = "ARN del Target Group para el ALB"
  type        = string
}

variable "database_endpoint" {
  description = "Endpoint de la base de datos RDS"
  type        = string
}

variable "database_username" {
  description = "Usuario para la base de datos"
  type        = string
}

variable "database_password" {
  description = "Contraseña para la base de datos"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "tags" {
  description = "Etiquetas adicionales para los recursos"
  type        = map(string)
  default     = {}
}

# Validación de parámetros para optimización de JVM
locals {
  # Validación de parámetros de JVM
  validate_jvm_heap_size = can(regex("^[0-9]+[mMgG]$", var.jvm_heap_size)) ? true : "Tamaño de heap JVM debe terminar con m, M, g o G"
  validate_jvm_perm_size = can(regex("^[0-9]+[mMgG]$", var.jvm_perm_size)) ? true : "Tamaño de perm gen JVM debe terminar con m, M, g o G"
  validate_jvm_max_perm_size = can(regex("^[0-9]+[mMgG]$", var.jvm_max_perm_size)) ? true : "Tamaño máximo de perm gen JVM debe terminar con m, M, g o G"

  # Validación de algoritmo de garbage collection
  valid_gc_algorithms = [
    "UseSerialGC",
    "UseParallelGC",
    "UseConcMarkSweepGC",
    "UseG1GC"
  ]
  validate_jvm_gc_algorithm = contains(local.valid_gc_algorithms, var.jvm_gc_algorithm) ? true : "Algoritmo de GC no válido"

  # Validación de puertos
  validate_tomcat_port = var.tomcat_port == 8080 || var.tomcat_port == 80 || var.tomcat_port == 443 ? true : "Puerto de Tomcat no válido"
}

variable "tomcat_port" {
  description = "Puerto donde escucha el servidor Tomcat"
  type        = number
  default     = 8080
}

variable "ssh_cidr_blocks" {
  description = "Bloques CIDR permitidos para acceso SSH"
  type        = list(string)
}

// === ARCHIVO: modules/network_infra/variables.tf ===
# Variables para el módulo de infraestructura de red
# Configuración de VPC, subredes, NAT Gateway y otros componentes de red

variable "project_name" {
  description = "Nombre del proyecto para etiquetado"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
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

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway para salida a Internet desde subredes privadas"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Usar un único NAT Gateway para todas las subredes privadas (para ahorro de costos)"
  type        = bool
  default     = true
}

variable "one_nat_gateway_per_az" {
  description = "Crear un NAT Gateway por zona de disponibilidad (alta disponibilidad)"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Habilitar DNS hostnames en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Etiquetas adicionales para los recursos de red"
  type        = map(string)
  default     = {}
}

variable "http_cidr_blocks" {
  description = "Bloques CIDR permitidos para acceso HTTP/HTTPS"
  type        = list(string)
}

variable "ssh_cidr_blocks" {
  description = "Bloques CIDR permitidos para acceso SSH"
  type        = list(string)
}

# Validación de parámetros de red
locals {
  # Validación de CIDR blocks
  validate_vpc_cidr = can(cidrhost(var.vpc_cidr, 0)) ? true : "CIDR de VPC no válido"

  validate_public_subnets = alltrue([
    for cidr in var.public_subnets_cidr : can(cidrhost(cidr, 0))
  ]) ? true : "Uno o más CIDR de subredes públicas no válidos"

  validate_private_subnets = alltrue([
    for cidr in var.private_subnets_cidr : can(cidrhost(cidr, 0))
  ]) ? true : "Uno o más CIDR de subredes privadas no válidos"

  # Validación de zonas de disponibilidad
  validate_az_count = length(var.availability_zones) >= 2 ? true : "Se requieren al menos 2 zonas de disponibilidad"

  # Validación de NAT Gateway
  validate_nat_config = !(var.single_nat_gateway && var.one_nat_gateway_per_az) ? true : "No se puede configurar single_nat_gateway y one_nat_gateway_per_az simultáneamente"

  # Validación de bloques CIDR para acceso
  validate_http_cidr = alltrue([
    for cidr in var.http_cidr_blocks : can(cidrhost(cidr, 0))
  ]) ? true : "Uno o más CIDR de acceso HTTP no válidos"

  validate_ssh_cidr = alltrue([
    for cidr in var.ssh_cidr_blocks : can(cidrhost(cidr, 0))
  ]) ? true : "Uno o más CIDR de acceso SSH no válidos"
}

// === ARCHIVO: main.tf ===
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

// === ARCHIVO: outputs.tf ===
output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.network_infra.vpc_id
}

output "vpc_cidr" {
  description = "CIDR de la VPC"
  value       = module.network_infra.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = module.network_infra.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = module.network_infra.private_subnet_ids
}

output "nat_gateway_ips" {
  description = "IPs de los NAT Gateways"
  value       = module.network_infra.nat_gateway_ips
}

output "alb_dns_name" {
  description = "Nombre DNS del Application Load Balancer"
  value       = aws_lb.tomcat.dns_name
}

output "alb_zone_id" {
  description = "Zone ID del ALB para Route 53"
  value       = aws_lb.tomcat.zone_id
}

output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = aws_lb.tomcat.arn
}

output "alb_security_group_id" {
  description = "ID del security group del ALB"
  value       = module.network_infra.alb_security_group_id
}

output "target_group_arn" {
  description = "ARN del target group de Tomcat"
  value       = aws_lb_target_group.tomcat.arn
}

output "tomcat_instance_id" {
  description = "ID de la instancia EC2 de Tomcat (solo si no hay ASG)"
  value       = var.enable_auto_scaling ? "" : module.tomcat_server.instance_id
  sensitive  = false
}

output "tomcat_instance_private_ip" {
  description = "IP privada de la instancia EC2 de Tomcat"
  value       = var.enable_auto_scaling ? "" : module.tomcat_server.instance_private_ip
  sensitive  = false
}

output "tomcat_security_group_id" {
  description = "ID del security group de Tomcat"
  value       = module.tomcat_server.security_group_id
}

output "autoscaling_group_name" {
  description = "Nombre del Auto Scaling Group"
  value       = var.enable_auto_scaling ? module.tomcat_server.autoscaling_group_name : ""
}

output "autoscaling_group_id" {
  description = "ID del Auto Scaling Group"
  value       = var.enable_auto_scaling ? module.tomcat_server.autoscaling_group_id : ""
}

output "instance_profile_name" {
  description = "Nombre del instance profile para SSM"
  value       = aws_iam_instance_profile.ec2_ssm_profile.name
}

output "kms_key_arn" {
  description = "ARN de la clave KMS para cifrado de EBS"
  value       = aws_kms_key.ebs_encryption.arn
}

output "kms_key_id" {
  description = "ID de la clave KMS para cifrado de EBS"
  value       = aws_kms_key.ebs_encryption.key_id
}

output "logs_bucket_name" {
  description = "Nombre del bucket S3 para logs de Tomcat"
  value       = aws_s3_bucket.tomcat_logs.id
}

output "sns_topic_arn" {
  description = "ARN del topic SNS para alertas"
  value       = aws_sns_topic.tomcat_alerts.arn
}

output "account_id" {
  description = "ID de la cuenta de AWS"
  value       = data.aws_caller_identity.current.account_id
}

output "region" {
  description = "Región de AWS"
  value       = var.aws_region
}

output "environment" {
  description = "Ambiente de despliegue"
  value       = var.environment
}

output "tomcat_url" {
  description = "URL pública del servidor Tomcat"
  value       = var.tomcat_ssl_enabled ? "https://${aws_lb.tomcat.dns_name}" : "http://${aws_lb.tomcat.dns_name}"
}

output "jvm_configuration" {
  description = "Configuración JVM aplicada al servidor Tomcat"
  value = {
    heap_size            = var.jvm_heap_size
    gc_type              = var.jvm_gc_type
    metaspace_size       = var.jvm_metaspace_size
    thread_stack_size    = var.jvm_thread_stack_size
    gc_log_enabled       = var.jvm_gc_log_enabled
  }
  sensitive = false
}

output "tomcat_connector_config" {
  description = "Configuración del connector de Tomcat"
  value = {
    max_threads          = var.tomcat_max_threads
    min_spare_threads    = var.tomcat_min_spare_threads
    connection_timeout   = var.tomcat_connection_timeout
    accept_count         = var.tomcat_accept_count
    compression_enabled  = var.tomcat_enable_compression
  }
  sensitive = false
}

// === ARCHIVO: backend.tf ===
terraform {
  backend "s3" {
    bucket         = "terraform-state-${var.project_name}-${var.environment}"
    key            = "infrastructure/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "terraform-state-lock-${var.environment}"

    versioning = true
    acl        = "bucket-owner-full-control"

    lifecycle {
      prevent_destroy = true
    }
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-${var.project_name}-${var.environment}"

  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Purpose     = "Terraform State Storage"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-state-lock-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    attribute_name = "ExpiresAt"
    enabled        = true
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Purpose     = "Terraform State Lock"
    ManagedBy   = "Terraform"
  }
}

resource "aws_dynamodb_table_item" "terraform_lock_initial" {
  table_name = aws_dynamodb_table.terraform_lock.name
  hash_key   = aws_dynamodb_table.terraform_lock.hash_key

  item = jsonencode({
    LockID = {
      S = "infrastructure/terraform.tfstate"
    }
    Info = {
      S = "Initial lock entry for ${var.environment} environment"
    }
    Operation = {
      S = "Init"
    }
  })
}

resource "aws_kms_key" "terraform_state" {
  description             = "KMS key for terraform state encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "terraform-state-key-policy"
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
        Sid    = "Allow S3 to use this key for bucket encryption"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Purpose     = "Terraform State Encryption"
  }
}

resource "aws_kms_alias" "terraform_state" {
  name          = "alias/terraform-state-${var.environment}"
  target_key_id = aws_kms_key.terraform_state.key_id
}

// === ARCHIVO: README.md ===
# Infraestructura AWS para Servidores de Aplicación Apache Tomcat

## Descripción del Proyecto

Este repositorio contiene la infraestructura como código (IaC) para aprovisionar servidores de aplicación Apache Tomcat en AWS, utilizando Terraform. El proyecto implementa una arquitectura modular con separación de ambientes (dev, qa, prod) y backend remoto para gestión de estado.

## Requisitos Previos

- Terraform >= 1.5.0 (instalar desde https://www.terraform.io/downloads)
- AWS CLI configurado con credenciales válidas (https://aws.amazon.com/cli/)
- Acceso a un bucket S3 para backend remoto
- Acceso a DynamoDB para locking de estado

## Estructura del Proyecto

```
.
├── backend.tf                 # Configuración de backend remoto
├── main.tf                    # Orquestación de módulos
├── outputs.tf                 # Outputs del root module
├── providers.tf               # Proveedor AWS
├── variables.tf               # Variables globales
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars   # Variables para desarrollo
│   ├── qa/
│   │   └── terraform.tfvars   # Variables para QA
│   └── prod/
│       └── terraform.tfvars   # Variables para producción
├── modules/
│   ├── network_infra/
│   │   ├── main.tf            # Recursos de red (VPC, subnets, etc.)
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── tomcat_server/
│       ├── main.tf            # Servidor Tomcat EC2
│       │   ├── outputs.tf
│       │   └── variables.tf
└── scripts/
    ├── configure_tomcat.sh    # Script de configuración de Tomcat
    └── load_test.sh           # Script de pruebas de carga
```

## Diagrama de Arquitectura

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           AWS Cloud                                          │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                        VPC (10.0.0.0/16)                           │   │
│  │  ┌─────────────────────────────────────────────────────────────┐   │   │
│  │  │  Subred Pública 1a (10.0.1.0/24)                            │   │   │
│  │  │  ┌─────────────────────────────────────────────────────┐    │   │   │
│  │  │  │  ALB (Application Load Balancer)                     │    │   │   │
│  │  │  │  - Listener: Puerto 80/443                           │    │   │   │
│  │  │  │  - Target Group: Tomcat Servers                      │    │   │   │
│  │  │  └─────────────────────────────────────────────────────┘    │   │   │
│  │  └─────────────────────────────────────────────────────────────┘   │   │
│  │  ┌─────────────────────────────────────────────────────────────┐   │   │
│  │  │  Subred Privada 1a (10.0.10.0/24)                          │   │   │
│  │  │  ┌─────────────────────────────────────────────────────┐    │   │   │
│  │  │  │  EC2 Instance - Tomcat Server 1                      │    │   │   │
│  │  │  │  - Apache Tomcat 9.x                                  │    │   │   │
│  │  │  │  - Java 17 (JDK)                                      │    │   │   │
│  │  │  │  - Security Group: Puerto 8080 (APP), 22 (SSH)       │    │   │   │
│  │  │  └─────────────────────────────────────────────────────┘    │   │   │
│  │  └─────────────────────────────────────────────────────────────┘   │   │
│  │  ┌─────────────────────────────────────────────────────────────┐   │   │
│  │  │  Subred Privada 1b (10.0.20.0/24)                          │   │   │
│  │  │  ┌─────────────────────────────────────────────────────┐    │   │   │
│  │  │  │  EC2 Instance - Tomcat Server 2                      │    │   │   │
│  │  │  │  - Apache Tomcat 9.x                                  │    │   │   │
│  │  │  │  - Java 17 (JDK)                                      │    │   │   │
│  │  │  │  - Security Group: Puerto 8080 (APP), 22 (SSH)       │    │   │   │
│  │  │  └─────────────────────────────────────────────────────┘    │   │   │
│  │  └─────────────────────────────────────────────────────────────┘   │   │
│  │                                                                      │   │
│  │  ┌─────────────────────────────────────────────────────────────┐   │   │
│  │  │  RDS Subnet Group (Multi-AZ)                               │   │   │
│  │  │  - Subred Privada 1a                                        │   │   │
│  │  │  - Subred Privada 1b                                        │   │   │
│  │  └─────────────────────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  S3 Bucket (Backend de Terraform)                                  │   │
│  │  DynamoDB Table (State Locking)                                    │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Configuración de Backend Remoto

El proyecto utiliza S3 como backend para almacenar el estado de Terraform de forma remota, con DynamoDB para el locking de estado y prevención de conflictos en equipos.

### Bucket S3 Requerido

Crear un bucket S3 con las siguientes propiedades:
- Versioning habilitado
- Encriptación SSE-S3 o SSE-KMS
- Lifecycle rules para limpieza de estados antiguos (opcional)

### Tabla DynamoDB Requerida

Crear una tabla DynamoDB con:
- Partition key: `LockID` (String)
- Modo de capacidad: PAY_PER_REQUEST

## Despliegue por Ambiente

### 1. Desarrollo (dev)

```bash
cd environments/dev
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

### 2. QA

```bash
cd environments/qa
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

### 3. Producción (prod)

```bash
cd environments/prod
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

**Nota**: Para producción, se recomienda revisar el plan antes de aplicar y utilizar aprobation automática solo en pipelines CI/CD automatizados.

## Configuración de Variables

Cada ambiente tiene su propio archivo `terraform.tfvars` con los valores específicos:

| Variable | Descripción | Ejemplo dev | Ejemplo prod |
|----------|-------------|-------------|--------------|
| `environment` | Nombre del ambiente | "dev" | "prod" |
| `region` | Región AWS | "us-east-1" | "us-east-1" |
| `vpc_cidr` | CIDR de VPC | "10.0.0.0/16" | "10.1.0.0/16" |
| `instance_type` | Tipo de instancia EC2 | "t3.medium" | "t3.large" |
| `tomcat_version` | Versión de Tomcat | "9.0.83" | "9.0.83" |
| `jvm_heap_size` | Tamaño máximo de heap JVM | "512m" | "2048m" |
| `desired_capacity` | Número de instancias | 2 | 4 |
| `min_capacity` | Capacidad mínima | 1 | 2 |
| `max_capacity` | Capacidad máxima | 3 | 6 |

## Módulos del Proyecto

### network_infra

Este módulo aprovisiona la infraestructura de red necesaria:
- VPC con CIDR configurable
- Subnets públicas y privadas en múltiples AZs
- Internet Gateway y NAT Gateways
- Tablas de enrutamiento
- Security Groups para ALB y servidores Tomcat

### tomcat_server

Este módulo aprovisiona los servidores de aplicación:
- Instancias EC2 con Apache Tomcat
- Configuración de JVM optimizada
- Auto Scaling Group con políticas
- Application Load Balancer
- Target Groups para distribución de tráfico
- CloudWatch Logs para monitoreo

## Etiquetado de Recursos

Todos los recursos incluyen tags consistentes para facilitar la identificación y facturación:

```hcl
tags = {
  Environment = var.environment
  Project     = "banca-digital"
  ManagedBy   = "terraform"
  Owner       = "cloud-ops-team"
  CostCenter  = "it-operations"
}
```

## Seguridad

### Principios Implementados

- **Menor privilegio**: Security Groups restrictivos permitiendo solo tráfico necesario
- **Red privada**: Servidores Tomcat en subredes privadas, solo accesibles via ALB
- **Cifrado**: Datos en reposo (EBS, RDS) y en tránsito (TLS/SSL)
- **Gestión de claves**: Uso de AWS KMS para cifrado
- **Acceso limitado**: SSH restringido a IP de gestión via Security Group

### Puertos Habilitados

| Puerto | Servicio | Origen | Destino |
|--------|----------|--------|---------|
| 22 | SSH | IP Admin | Servidores Tomcat |
| 80 | HTTP | ALB | Servidores Tomcat |
| 443 | HTTPS | ALB | Servidores Tomcat |
| 8080 | HTTP App | ALB | Servidores Tomcat |

## Monitoreo y Observabilidad

### CloudWatch Metrics

- CPU Utilization
- Memory Utilization
- Network Bytes
- Disk Usage
- Tomcat Thread Pool

### Alarmas Configuradas

- CPU > 80% por 5 minutos
- Memory > 85% por 5 minutos
- ALB Target Response Time > 2s
- Instance Health Check Failed

## Optimización de Costos

Para optimizar costos en el entorno de desarrollo:

- Instancias spot para desarrollo (ahorro hasta 70%)
- Auto Scaling con políticas de escala basada en utilización
- Apagado programado de instancias no productivas (horario laboral)
- Uso de Reserved Instances para producción
- Etiquetado para asignación de costos por ambiente

## Referencias Externas

- Documentación oficial de Terraform: https://www.terraform.io/docs
- AWS Provider Terraform: https://registry.terraform.io/providers/hashicorp/aws
- Módulo VPC de Terraform AWS: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws
- Apache Tomcat Official: https://tomcat.apache.org/
- AWS Well-Architected Framework: https://aws.amazon.com/architecture/well-architected/

## Mantenimiento

### Actualización de Terraform

```bash
# Actualizar versión de Terraform
terraform version

# Actualizar providers
terraform init -upgrade
```

### Limpieza de Estados Antiguos

```bash
# Listar versiones de estado
aws s3 ls s3://<bucket-name>/terraform/state/

# Eliminar estados antiguos (opcional)
aws s3 rm s3://<bucket-name>/terraform/state/<environment>/terraform.tfstate.<version>
```

## Troubleshooting

### Error: Backend authentication failed

Verificar credenciales AWS CLI:
```bash
aws sts get-caller-identity
```

### Error: State locking failed

Verificar tabla DynamoDB y permisos:
```bash
aws dynamodb describe-table --table-name <table-name>
```

### Error: Instance capacity

Verificar límites de la cuenta AWS para el tipo de instancia:
```bash
aws ec2 describe-account-attributes --attribute-names max-instances
```

## Licencia

Este proyecto es propiedad de la organización y está destinado exclusivamente para uso interno.


// === ARCHIVO: modules/tomcat_server/main.tf ===
locals {
  name_prefix = "tomcat-${var.environment}"
  common_tags = {
    Environment = var.environment
    Project     = "banca-digital"
    ManagedBy   = "terraform"
    Owner       = "cloudops-team"
  }
}

resource "aws_security_group" "tomcat_sg" {
  name        = "${local.name_prefix}-sg"
  description = "Security group for Tomcat server - allows HTTP and SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP access from ALB"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description = "HTTPS access from ALB"
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description = "SSH access from bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.bastion_cidr]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-sg"
  })
}

resource "aws_iam_role" "tomcat_instance_role" {
  name = "${local.name_prefix}-instance-role"

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

  tags = local.common_tags
}

resource "aws_iam_role_policy" "tomcat_ssm_policy" {
  name = "${local.name_prefix}-ssm-policy"
  role = aws_iam_role.tomcat_instance_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:DescribeAssociation",
          "ssm:GetDeployablePatchListForInstance",
          "ssm:GetDocument",
          "ssm:DescribeDocumentParameters",
          "ssm:GetManifest",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:ListAssociations",
          "ssm:ListInstanceAssociations",
          "ssm:PutInventory",
          "ssm:PutComplianceItems",
          "ssm:PutConfigurePackageResult",
          "ssm:UpdateAssociationStatus",
          "ssm:UpdateInstanceAssociationStatus",
          "ec2messages:AcknowledgeMessage",
          "ec2messages:DeleteMessage",
          "ec2messages:FailMessage",
          "ec2messages:GetEndpoint",
          "ec2messages:GetMessages",
          "ec2messages:SendReply",
          "ssm:ExecuteScript",
          "ssm:GetCommandInvocation",
          "ssm:ListCommands",
          "ssm:SendCommand"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::${var.app_bucket_name}/*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "tomcat_profile" {
  name = "${local.name_prefix}-profile"
  role = aws_iam_role.tomcat_instance_role.name

  tags = local.common_tags
}

resource "aws_launch_template" "tomcat_lt" {
  name_prefix   = local.name_prefix
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    arn = aws_iam_instance_profile.tomcat_profile.arn
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.tomcat_sg.id]
    subnet_id                   = var.subnet_id
  }

  user_data = base64encode(templatefile("${path.module}/../../scripts/configure_tomcat.sh", {
    environment      = var.environment
    jvm_heap_size    = var.jvm_heap_size
    jvm_gc_algorithm = var.jvm_gc_algorithm
    app_bucket       = var.app_bucket_name
  }))

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.common_tags, {
      Name = "${local.name_prefix}-instance"
    })
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = local.common_tags
}

resource "aws_autoscaling_group" "tomcat_asg" {
  name                = "${local.name_prefix}-asg"
  vpc_zone_identifier = [var.subnet_id]
  desired_capacity    = var.asg_desired_capacity
  min_size            = var.asg_min_size
  max_size            = var.asg_max_size
  health_check_type   = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.tomcat_lt.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-asg-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = "banca-digital"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${local.name_prefix}-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.tomcat_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${local.name_prefix}-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.tomcat_asg.name
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${local.name_prefix}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = var.cpu_threshold_high
  alarm_description   = "CPU utilization high - scale up"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.tomcat_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_up.arn]
  tags          = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${local.name_prefix}-cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 180
  statistic           = "Average"
  threshold           = var.cpu_threshold_low
  alarm_description   = "CPU utilization low - scale down"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.tomcat_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_down.arn]
  tags          = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  count               = var.enable_monitoring ? 1 : 0
  alarm_name          = "${local.name_prefix}-memory-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "mem_used_percent"
  namespace           = "System/Linux"
  period              = 120
  statistic           = "Average"
  threshold           = 85
  alarm_description   = "Memory utilization high"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.tomcat_asg.name
  }

  tags = local.common_tags
}

resource "aws_s3_bucket" "tomcat_logs" {
  bucket = "banca-digital-tomcat-logs-${var.environment}-${data.aws_caller_identity.current.account_id}"

  tags = merge(local.common_tags, {
    Name = "Tomcat logs bucket"
  })
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tomcat_logs" {
  bucket = aws_s3_bucket.tomcat_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "allow_cloudwatch_logs" {
  bucket = aws_s3_bucket.tomcat_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudWatchPutObject"
        Effect = "Allow"
        Principal = {
          Service = "logs.${var.region}.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.tomcat_logs.id}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl"    = "bucket-owner-full-control",
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}

data "aws_caller_identity" "current" {}
// === ARCHIVO: modules/tomcat_server/outputs.tf ===
output "security_group_id" {
  description = "ID del security group del servidor Tomcat"
  value       = aws_security_group.tomcat_sg.id
}

output "autoscaling_group_name" {
  description = "Nombre del Auto Scaling Group de Tomcat"
  value       = aws_autoscaling_group.tomcat_asg.name
}

output "autoscaling_group_arn" {
  description = "ARN del Auto Scaling Group de Tomcat"
  value       = aws_autoscaling_group.tomcat_asg.arn
}

output "launch_template_id" {
  description = "ID del Launch Template de Tomcat"
  value       = aws_launch_template.tomcat_lt.id
}

output "instance_profile_name" {
  description = "Nombre del perfil de instancia IAM"
  value       = aws_iam_instance_profile.tomcat_profile.name
}

output "instance_role_name" {
  description = "Nombre del rol de instancia IAM"
  value       = aws_iam_role.tomcat_instance_role.name
}

output "logs_bucket_name" {
  description = "Nombre del bucket de logs de Tomcat"
  value       = aws_s3_bucket.tomcat_logs.id
}

output "logs_bucket_arn" {
  description = "ARN del bucket de logs de Tomcat"
  value       = aws_s3_bucket.tomcat_logs.arn
}

output "scale_up_policy_arn" {
  description = "ARN de la política de scale-up del ASG"
  value       = aws_autoscaling_policy.scale_up.arn
}

output "scale_down_policy_arn" {
  description = "ARN de la política de scale-down del ASG"
  value       = aws_autoscaling_policy.scale_down.arn
}
// === ARCHIVO: modules/network_infra/main.tf ===
locals {
  name_prefix = "banca-digital-${var.environment}"
  common_tags = {
    Environment = var.environment
    Project     = "banca-digital"
    ManagedBy   = "terraform"
    Owner       = "cloudops-team"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = local.name_prefix
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  public_subnets  = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.common_tags

  public_subnet_tags = {
    Type = "public"
  }

  private_subnet_tags = {
    Type = "private"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = module.vpc.vpc_id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-igw"
  })
}

resource "aws_eip" "nat_gateway" {
  count  = length(var.availability_zones)
  domain = "vpc"

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-eip-${count.index}"
  })

  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "main" {
  count = length(var.availability_zones)

  allocation_id = aws_eip.nat_gateway[count.index].id
  subnet_id     = module.vpc.public_subnets[count.index]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nat-${count.index}"
  })

  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "private" {
  count = length(var.availability_zones)

  vpc_id = module.vpc.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-private-rt-${count.index}"
  })
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)

  subnet_id      = module.vpc.private_subnets[count.index]
  route_table_id = aws_route_table.private[count.index % length(var.availability_zones)].id
}

resource "aws_security_group" "alb_sg" {
  name        = "${local.name_prefix}-alb-sg"
  description = "Security group for ALB - allows HTTP/HTTPS traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-alb-sg"
  })
}

resource "aws_security_group" "bastion_sg" {
  name        = "${local.name_prefix}-bastion-sg"
  description = "Security group for bastion host - allows SSH from office"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from office IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.office_cidr]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-bastion-sg"
  })
}

resource "aws_lb" "main" {
  name               = "${local.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = var.environment == "prod" ? true : false

  tags = local.common_tags
}

resource "aws_lb_target_group" "tomcat" {
  name     = "${local.name_prefix}-tomcat-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/health"
    matcher             = "200"
  }

  stickiness {
    enabled  = true
    type     = "lb_cookie"
    cookie_duration = 86400
  }

  tags = local.common_tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tomcat.arn
  }
}

resource "aws_lb_listener" "https" {
  count = var.enable_https ? 1 : 0

  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tomcat.arn
  }
}

resource "aws_instance" "bastion" {
  count = var.enable_bastion ? 1 : 0

  ami           = var.bastion_ami
  instance_type = var.bastion_instance_type
  subnet_id     = module.vpc.public_subnets[0]
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-bastion"
  })
}

resource "aws_route53_zone" "private" {
  count = var.enable_private_dns ? 1 : 0

  name = "banca-digital.internal"

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  tags = local.common_tags
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"

  route_table_ids = concat(
    module.vpc.private_route_table_ids,
    [aws_route_table.private[0].id]
  )

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-s3-endpoint"
  })
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.region}.ssm"

  route_table_ids = module.vpc.private_route_table_ids

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-ssm-endpoint"
  })
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.region}.logs"

  route_table_ids = module.vpc.private_route_table_ids

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-logs-endpoint"
  })
}

resource "aws_flow_log" "vpc_flow_logs" {
  log_destination      = var.flow_logs_bucket_arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = module.vpc.vpc_id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-flow-logs"
  })
}


// === ARCHIVO: modules/network_infra/outputs.tf ===
output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = module.vpc.private_subnets
}

output "private_subnet_arns" {
  description = "ARNs de las subredes privadas para conexiones internas"
  value       = [for subnet in module.vpc.private_subnet_arns : subnet]
}

output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = aws_lb.alb.arn
}

output "alb_dns_name" {
  description = "Nombre DNS del ALB para acceso externo"
  value       = aws_lb.alb.dns_name
}

output "alb_zone_id" {
  description = "Zone ID del ALB para configuración de Route 53"
  value       = aws_lb.alb.zone_id
}

output "alb_target_group_arn" {
  description = "ARN del target group del ALB para registrar instancias Tomcat"
  value       = aws_lb_target_group.tomcat.arn
}

output "security_group_alb_id" {
  description = "ID del security group del ALB"
  value       = aws_security_group.alb.id
}

output "security_group_tomcat_id" {
  description = "ID del security group para instancias Tomcat"
  value       = aws_security_group.tomcat.id
}

output "nat_gateway_ips" {
  description = "IPs elásticas de los NAT Gateways para salida a internet"
  value       = [for ngw in aws_nat_gateway.main : ngw.elastic_allocation_id]
}

output "igw_id" {
  description = "ID del Internet Gateway para conectividad pública"
  value       = module.vpc.igw_id
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = module.vpc.public_route_table_ids[0]
}

output "private_route_table_ids" {
  description = "IDs de las tablas de rutas privadas por AZ"
  value       = module.vpc.private_route_table_ids
}


// === ARCHIVO: environments/dev/terraform.tfvars ===
environment               = "dev"
project_name             = "banca-digital"
owner                    = "cloud-ops-team"

# Configuración de red para desarrollo
vpc_cidr                 = "10.0.0.0/16"
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs     = ["10.0.10.0/24", "10.0.20.0/24"]
availability_zones      = ["us-east-1a", "us-east-1b"]

# Configuración de instancia EC2 para desarrollo
instance_type            = "t3.medium"
instance_count           = 1
ami_id                   = "ami-0c55b159cbfafe1f0"
key_name                 = "banca-digital-dev-key"

# Configuración de Tomcat para desarrollo
tomcat_version           = "9.0.85"
tomcat_port              = 8080
tomcat_ssl_enabled       = false
max_threads              = 150
min_spare_threads        = 25

# Configuración de JVM optimizada para desarrollo
jvm_heap_min             = "512m"
jvm_heap_max             = "1024m"
jvm_metaspacesize        = "128m"
jvm_max_metaspacesize    = "256m"
jvm_gc_algorithm         = "G1GC"
jvm_gc_log_enabled       = true
jvm_gc_log_size          = "50m"
jvm_gc_log_max_files     = 5
jvm_extra_opts           = "-XX:+UseStringDeduplication -XX:+ParallelRefProcEnabled"
jvm_agents_enabled       = false

# Configuración de seguridad para desarrollo
allowed_ssh_cidr         = ["10.0.0.0/16"]
allowed_app_cidr         = ["10.0.0.0/16"]
ssh_port                 = 22
enable_monitoring        = true
enable_logging           = true

# Configuración de almacenamiento
root_volume_size         = 20
data_volume_size         = 30
volume_type              = "gp3"

# Configuración de costos y etiquetas
cost_center              = "CC-DEV-001"
enable_cost_alerts       = false
budget_limit_monthly     = 100.0

# Configuración de alta disponibilidad para desarrollo
enable_health_checks     = true
health_check_interval    = 30
health_check_timeout     = 5
health_check_unhealthy   = 3

// === ARCHIVO: environments/qa/terraform.tfvars ===
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

// === ARCHIVO: environments/prod/terraform.tfvars ===
environment               = "prod"
project_name             = "banca-digital"
owner                    = "cloud-ops-team"

# Configuración de red para producción
vpc_cidr                 = "10.2.0.0/16"
public_subnet_cidrs      = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
private_subnet_cidrs     = ["10.2.10.0/24", "10.2.20.0/24", "10.2.30.0/24"]
availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Configuración de instancia EC2 para producción - optimizado para 10k req/min
instance_type            = "r6i.2xlarge"
instance_count           = 4
ami_id                   = "ami-0c55b159cbfafe1f0"
key_name                 = "banca-digital-prod-key"
tenancy                  = "default"
placement_group_enabled  = true

# Configuración de Tomcat para producción
tomcat_version           = "9.0.85"
tomcat_port              = 8080
tomcat_ssl_enabled       = true
tomcat_ssl_port          = 8443
max_threads              = 800
min_spare_threads        = 100
connection_timeout       = 10000
max_connections          = 20000
acceptor_thread_count    = 4
poller_thread_count      = 4
enable_compression       = true
compression_min_size     = 1024

# Configuración de JVM optimizada para producción - 10k req/min
jvm_heap_min             = "4096m"
jvm_heap_max             = "8192m"
jvm_metaspacesize        = "512m"
jvm_max_metaspacesize    = "1024m"
jvm_gc_algorithm         = "ZGC"
jvm_gc_log_enabled       = true
jvm_gc_log_size          = "200m"
jvm_gc_log_max_files     = 20
jvm_extra_opts           = "-XX:+UseStringDeduplication -XX:+ParallelRefProcEnabled -XX:+UnlockCommercialFeatures -XX:+FlightRecorder -XX:NativeMemoryTracking=summary -XX:+AlwaysPreTouch -XX:+UseLargePages -XX:+UseTransparentHugePages"
jvm_agents_enabled       = true
jvm_heap_dump_enabled    = true
jvm_heap_dump_path       = "/opt/tomcat/logs"
jvm_heap_dump_on_oom     = true
jvm_remote_debug_enabled = false

# Configuración de seguridad para producción - principio de menor privilegio
allowed_ssh_cidr         = ["10.2.0.0/16"]
allowed_app_cidr         = ["10.2.0.0/16", "10.3.0.0/16"]
ssh_port                 = 22
ssh_access_cidr          = ["10.2.0.0/24"]
enable_monitoring        = true
enable_logging           = true
enable_audit_logging     = true
enable_waf_protection    = true
enable_ddos_protection   = true

# Configuración de almacenamiento de alto rendimiento
root_volume_size         = 50
data_volume_size         = 100
volume_type              = "gp3"
io1_iops                 = 3000
io1_throughput           = 125
enable_ebs_optimized     = true

# Configuración de costos y etiquetas
cost_center              = "CC-PROD-001"
enable_cost_alerts       = true
budget_limit_monthly     = 5000.0
cost_alert_threshold     = 0.75
cost_tags_enabled        = true

# Configuración de alta disponibilidad para producción
enable_health_checks     = true
health_check_interval    = 10
health_check_timeout     = 3
health_check_unhealthy   = 2
health_check_healthy     = 2
enable_load_balancer     = true
lb_type                  = "application"
lb_deletion_protection   = true
lb_ssl_policy            = "ELBSecurityPolicy-2016-08"
enable_cross_zone_lb     = true

# Configuración de auto-scaling para producción
enable_auto_scaling      = true
asg_min_size             = 4
asg_max_size             = 12
asg_desired_capacity     = 4
scaling_cooldown         = 300
scaling_warmup            = 120
scale_up_threshold       = 70
scale_down_threshold     = 30
scale_up_adjustment      = 2
scale_down_adjustment    = 1

# Configuración de recuperación ante desastres
enable_backup            = true
backup_retention_days    = 30
backup_schedule          = "cron(0 5 ? * * *)"
rto_minutes              = 30
rpo_minutes              = 15
enable_multi_az_recovery = true


// === ARCHIVO: scripts/configure_tomcat.sh ===
#!/bin/bash
set -euo pipefail

# Script de configuración inicial de Apache Tomcat
# Optimizado para cargas de trabajo de aplicación de banca digital
# Configura parámetros de JVM, pooling de conexiones y seguridad

readonly SCRIPT_VERSION="1.0.0"
readonly TOMCAT_VERSION="9.0.83"
readonly TOMCAT_USER="tomcat"
readonly TOMCAT_GROUP="tomcat"
readonly APP_BASE="/opt/tomcat"
readonly JAVA_HOME="${JAVA_HOME:-/usr/lib/jvm/java-11-openjdk}"

echo "=== Iniciando configuración de Tomcat v${TOMCAT_VERSION} ==="
echo "Fecha: $(date -u +'%Y-%m-%d %H:%M:%S UTC')"
echo "Usuario: $(whoami)"
echo "JAVA_HOME: ${JAVA_HOME}"

# Verificar prerequisites
echo "[1/8] Verificando prerequisites del sistema..."
if ! command -v java &> /dev/null; then
    echo "ERROR: Java no encontrado. Instale OpenJDK 11 o superior."
    exit 1
fi

JAVA_VERSION=$(java -version 2>&1 | head -n1 | cut -d'"' -f2 | cut -d'.' -f1)
if [ "${JAVA_VERSION}" -lt 11 ]; then
    echo "ERROR: Se requiere Java 11 o superior. Versión actual: ${JAVA_VERSION}"
    exit 1
fi
echo "Java version ${JAVA_VERSION} verificada correctamente."

# Crear usuario y grupo de Tomcat
echo "[2/8] Creando usuario y grupo del sistema..."
if ! getent group "${TOMCAT_GROUP}" > /dev/null 2>&1; then
    groupadd --system "${TOMCAT_GROUP}"
    echo "Grupo '${TOMCAT_GROUP}' creado."
fi

if ! getent passwd "${TOMCAT_USER}" > /dev/null 2>&1; then
    useradd --system --gid "${TOMCAT_GROUP}" --home-dir "${APP_BASE}" --shell /bin/false "${TOMCAT_USER}"
    echo "Usuario '${TOMCAT_USER}' creado."
fi

# Crear estructura de directorios
echo "[3/8] Creando estructura de directorios..."
mkdir -p "${APP_BASE}/"
mkdir -p "${APP_BASE}/conf"
mkdir -p "${APP_BASE}/logs"
mkdir -p "${APP_BASE}/webapps"
mkdir -p "${APP_BASE}/temp"
mkdir -p "${APP_BASE}/work"
mkdir -p "${APP_BASE}/lib"
mkdir -p "${APP_BASE}/bin"

# Descargar Tomcat si no existe
if [ ! -f "${APP_BASE}/bin/catalina.sh" ]; then
    echo "[4/8] Descargando Apache Tomcat..."
    readonly TOMCAT_URL="https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
    
    curl -fsSL --connect-timeout 30 --max-time 300 "${TOMCAT_URL}" -o /tmp/tomcat.tar.gz
    
    if [ ! -s /tmp/tomcat.tar.gz ]; then
        echo "ERROR: Falló la descarga de Tomcat"
        exit 1
    fi
    
    tar -xzf /tmp/tomcat.tar.gz -C /tmp/
    cp -r /tmp/apache-tomcat-${TOMCAT_VERSION}/* "${APP_BASE}/"
    rm -rf /tmp/tomcat.tar.gz /tmp/apache-tomcat-${TOMCAT_VERSION}
    echo "Tomcat extraído en ${APP_BASE}"
fi

# Configurar variables de entorno JVM
echo "[5/8] Configurando parámetros de JVM optimizados..."

cat > "${APP_BASE}/bin/setenv.sh" << 'ENVEOF'
#!/bin/bash
# Configuración de entorno JVM para Tomcat
# Optimizado para cargas de trabajo debanca digital
# Tuning de heap, garbage collection y rendimiento

# Configuración de Heap Size
# Basado en memoria disponible del sistema: 2GB para JVM de los 4GB totales
HEAP_SIZE="2048m"
MIN_HEAP="1024m"
MAX_HEAP="2048m"

# Parámetros de Garbage Collection
# G1GC para latencia reducida en aplicaciones web
GC_LOG_ENABLED="-Xlog:gc*:file=${CATALINA_HOME}/logs/gc.log:time,uptime,level,tags:filecount=10,filesize=10m"
GC_TUNING="-XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:G1HeapRegionSize=16m -XX:G1ReservePercent=10"

# Configuración de memoria y rendimiento
MEMORY_OPTS="-Xms${MIN_HEAP} -Xmx${MAX_HEAP} -XX:NewRatio=2 -XX:SurvivorRatio=8"
PERF_OPTS="-XX:+UseStringDeduplication -XX:+OptimizeStringConcat -XX:+AlwaysPreTouch"

# Configuración de threads y conexiones
THREAD_OPTS="-XX:NativeMemoryTracking=summary -XX:+UseLargePages -XX:+UseTLAB"

# Seguridad y auditoría
SECURITY_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true"

# JMX para monitoreo
JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9090 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=true"

# Ensamblar opciones de JVM
export CATALINA_OPTS="${HEAP_SIZE} ${GC_LOG_ENABLED} ${GC_TUNING} ${MEMORY_OPTS} ${PERF_OPTS} ${THREAD_OPTS} ${SECURITY_OPTS} ${JMX_OPTS}"
export JAVA_OPTS="-server ${CATALINA_OPTS}"
export JAVA_HOME="${JAVA_HOME:-/usr/lib/jvm/java-11-openjdk}"

# Configuración de pooling de conexiones HTTP
# Maximizar throughput con conexiones persistentes
export CATALINA_OPTS="${CATALINA_OPTS} -Dhttp.maxConnections=10000 -Dhttp.maxKeepAliveRequests=100"

echo "[CONFIG] JVM Heap: ${MIN_HEAP} - ${MAX_HEAP}"
echo "[CONFIG] GC: G1GC con MaxGCPauseMillis=200"
echo "[CONFIG] JMX enabled en puerto 9090"
ENVEOF

chmod +x "${APP_BASE}/bin/setenv.sh"
echo "Archivo setenv.sh configurado con parámetros de JVM optimizados."

# Configurar server.xml con pooling de conexiones y connectors optimizados
echo "[6/8] Configurando server.xml con pooling de conexiones..."

cat > "${APP_BASE}/conf/server.xml" << 'SERVEREOF'
<?xml version="1.0" encoding="UTF-8"?>
<Server port="8005" shutdown="SHUTDOWN">
  <Listener className="org.apache.catalina.startup.VersionLoggerListener" />
  <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
  <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
  <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
  <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />

  <GlobalNamingResources>
    <Resource name="UserDatabase" auth="Container"
              type="org.apache.catalina.UserDatabase"
              description="User database that can be updated and saved"
              factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
              pathname="conf/tomcat-users.xml" />
  </GlobalNamingResources>

  <Service name="Catalina">
    <!-- Connector NIO optimizado para alto rendimiento -->
    <Connector port="8080" protocol="org.apache.coyote.http11.Http11NioProtocol"
               maxThreads="400" minSpareThreads="50" 
               acceptCount="200" connectionTimeout="20000"
               enableLookups="false" maxConnections="10000"
               acceptorThreadCount="4" pollerThreadCount="4"
               compression="on" compressionMinSize="2048"
               noCompressionUserAgents="gozilla,traviata"
               compressibleMimeType="text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json"
               URIEncoding="UTF-8" 
               connectionLinger="-1"
               socketBuffer="9000"
               maxKeepAliveRequests="100"
               keepAliveTimeout="5000"
               redirectPort="8443" />

    <!-- Connector AJP para integración con Apache/Nginx -->
    <Connector protocol="AJP/1.3"
               address="127.0.0.1"
               port="8009"
               redirectPort="8443"
               maxThreads="400"
               connectionTimeout="600000"
               maxParameterCount="10000"
               packetSize="65536" />

    <Engine name="Catalina" defaultHost="localhost">
      <Realm className="org.apache.catalina.realm.LockOutRealm">
        <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
               resourceName="UserDatabase"/>
      </Realm>

      <Host name="localhost"  appBase="webapps"
            unpackWARs="true" autoDeploy="true">
        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
               prefix="localhost_access_log" suffix=".txt"
               pattern="%h %l %u %t &quot;%r&quot; %s %b %D %a" />
      </Host>
    </Engine>
  </Service>
</Server>
SERVEREOF

echo "server.xml configurado con pooling de conexiones y connectors optimizados."

# Configurar contexto de aplicación con pooling de datasource
echo "[7/8] Configurando contexto y datasource..."

cat > "${APP_BASE}/conf/context.xml" << 'CONTEXTEOF'
<?xml version="1.0" encoding="UTF-8"?>
<Context reloadable="true" swallowReport="true">
    <!-- Configuración de pooling de conexiones de base de datos -->
    <Resource name="jdbc/BankingDB"
              auth="Container"
              type="javax.sql.DataSource"
              factory="org.apache.tomcat.jdbc.pool.DataSourceFactory"
              driverClassName="org.postgresql.Driver"
              url="jdbc:postgresql://${DB_HOST:-localhost}:${DB_PORT:-5432}/${DB_NAME:-banking}"
              username="${DB_USER:-tomcat}"
              password="${DB_PASSWORD:-changeme}"
              maxActive="100"
              maxIdle="30"
              maxWait="10000"
              initialSize="10"
              validationQuery="SELECT 1"
              validationInterval="30000"
              testOnBorrow="true"
              testWhileIdle="true"
              testOnReturn="false"
              timeBetweenEvictionRunsMillis="30000"
              minEvictableIdleTimeMillis="60000"
              removeAbandoned="true"
              removeAbandonedTimeout="60"
              logAbandoned="true"
              abandonWhenPercentageFull="50"
              maxAge="3600000"
              suspectTimeout="30"
              fairQueue="true"
              jmxEnabled="true"
              jdbcInterceptors="org.apache.tomcat.jdbc.pool.interceptor.ConnectionState;org.apache.tomcat.jdbc.pool.interceptor.StatementFinalizer"
              />
    
    <!-- Configuración de sesión distribuida -->
    <Manager pathname="" />
</Context>
CONTEXTEOF

echo "context.xml configurado con pooling de conexiones."

# Configurar seguridad y permisos
echo "[8/8] Aplicando configuraciones de seguridad..."

# Establecer permisos apropiados
chown -R "${TOMCAT_USER}:${TOMCAT_GROUP}" "${APP_BASE}"
chmod -R u=rwX,g=rX,o=rX "${APP_BASE}"
chmod u+x "${APP_BASE}/bin/*.sh"

# Crear archivo de políticas de seguridad
cat > "${APP_BASE}/conf/catalina.policy" << 'POLICYEOF'
// Política de seguridad para Tomcat
// Configurada para aplicación de banca digital

grant {
    // Permisos del código de Tomcat
    permission java.security.AllPermission;
};

// Restricciones específicas para aplicaciones web
grant codeBase "file:${catalina.base}/webapps/-" {
    permission java.net.SocketPermission "localhost" "connect,resolve";
    permission java.net.SocketPermission "*.amazonaws.com" "connect,resolve";
    permission java.net.SocketPermission "*.internal" "connect,resolve";
    permission java.io.FilePermission "${catalina.base}/logs/-" "read,write";
    permission java.io.FilePermission "${catalina.base}/temp/-" "read,write,delete";
};
POLICYEOF

# Habilitar SSL/TLS configuración básica
cat > "${APP_BASE}/conf/web.xml" << 'WEBXMLEOF'
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee
                             http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">

    <display-name>Banking Application</display-name>
    
    <session-config>
        <session-timeout>30</session-timeout>
        <cookie-config>
            <http-only>true</http-only>
            <secure>false</secure>
        </cookie-config>
        <tracking-mode>COOKIE</tracking-mode>
    </session-config>

    <security-constraint>
        <web-resource-collection>
            <web-resource-name>Protected Area</web-resource-name>
            <url-pattern>/*</url-pattern>
        </web-resource-collection>
        <user-data-constraint>
            <transport-guarantee>NONE</transport-guarantee>
        </user-data-constraint>
    </security-constraint>

    <error-page>
        <error-code>404</error-code>
        <location>/error/404.html</location>
    </error-page>
    <error-page>
        <error-code>500</error-code>
        <location>/error/500.html</location>
    </error-page>
</web-app>
WEBXMLEOF

echo "Configuraciones de seguridad aplicadas."

# Verificar instalación
echo ""
echo "=== Verificando instalación de Tomcat ==="
if [ -f "${APP_BASE}/bin/catalina.sh" ]; then
    echo "✓ Catalina.sh encontrado"
fi

if [ -f "${APP_BASE}/bin/setenv.sh" ]; then
    echo "✓ setenv.sh configurado"
fi

if [ -f "${APP_BASE}/conf/server.xml" ]; then
    echo "✓ server.xml configurado"
fi

echo ""
echo "=== Configuración de Tomcat completada ==="
echo "Directorio base: ${APP_BASE}"
echo "Usuario: ${TOMCAT_USER}"
echo "Puerto HTTP: 8080"
echo "Puerto AJP: 8009"
echo "Puerto shutdown: 8005"
echo ""
echo "Para iniciar Tomcat: sudo su - ${TOMCAT_USER} -c '${APP_BASE}/bin/startup.sh'"
echo "Para detener Tomcat: sudo su - ${TOMCAT_USER} -c '${APP_BASE}/bin/shutdown.sh'"
echo ""
echo "Logs disponibles en: ${APP_BASE}/logs/"
// === ARCHIVO: scripts/load_test.sh ===
#!/bin/bash
set -euo pipefail

# Script de pruebas de carga para Apache Tomcat
# Utiliza Apache Benchmark (ab) para generar carga HTTP
# Genera reportes de rendimiento en formato texto y JSON

readonly SCRIPT_VERSION="1.0.0"
readonly DEFAULT_CONCURRENCY=50
readonly DEFAULT_REQUESTS=1000
readonly DEFAULT_TARGET_PATH="/banking/api/health"
readonly REPORT_DIR="${REPORT_DIR:-/tmp/load_tests}"

# Colores para output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Función para mostrar usage
usage() {
    cat << EOF
Uso: $0 [OPCIONES]

Opciones:
    -u, --url URL              URL base del servidor (requerido)
    -p, --path RUTA            Path a probar (default: ${DEFAULT_TARGET_PATH})
    -n, --requests NUM         Total de peticiones (default: ${DEFAULT_REQUESTS})
    -c, --concurrency NUM      Número de clientes concurrentes (default: ${DEFAULT_CONCURRENCY})
    -m, --method METODO        Método HTTP (GET, POST, PUT, DELETE) (default: GET)
    -t, --timeout SEG          Timeout por request en segundos (default: 30)
    -H, --header CABECERA      Cabecera adicional (formato: "Name: Value")
    -d, --data DATOS           Body para POST/PUT (ruta a archivo o datos)
    -o, --output DIR           Directorio para reportes (default: ${REPORT_DIR})
    -r, --runs NUM             Número de ejecuciones del test (default: 1)
    -w, --warmup               Ejecutar warmup antes del test principal
    -h, --help                 Mostrar esta ayuda

Ejemplos:
    $0 -u http://localhost:8080 -n 10000 -c 100
    $0 -u https://prod.banking.com -p /api/accounts -c 200 -n 50000 -r 3
    $0 -u http://localhost:8080 -p /api/transfer -m POST -d payload.json

EOF
    exit 1
}

# Función de logging
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Verificar que ab está instalado
check_prerequisites() {
    log_info "Verificando prerequisites..."
    
    if ! command -v ab &> /dev/null; then
        log_error "Apache Benchmark (ab) no encontrado."
        log_info "Instalar en Ubuntu/Debian: sudo apt-get install apache2-utils"
        log_info "Instalar en RHEL/CentOS: sudo yum install httpd-tools"
        log_info "Instalar en macOS: brew install httpd"
        exit 1
    fi
    
    local ab_version
    ab_version=$(ab -V 2>&1 | head -n1)
    log_success "Apache Benchmark disponible: ${ab_version}"
    
    # Verificar herramientas adicionales
    if command -v jq &> /dev/null; then
        log_info "jq disponible para procesamiento JSON"
    else
        log_warn "jq no disponible, algunos reportes no se generarán"
    fi
    
    if command -v bc &> /dev/null; then
        log_info "bc disponible para cálculos"
    else
        log_error "bc no encontrado. Instale bc para ejecutar el script."
        exit 1
    fi
}

# Parsear argumentos
parse_arguments() {
    TARGET_URL=""
    TARGET_PATH="${DEFAULT_TARGET_PATH}"
    NUM_REQUESTS="${DEFAULT_REQUESTS}"
    CONCURRENCY="${DEFAULT_CONCURRENCY}"
    HTTP_METHOD="GET"
    TIMEOUT=30
    HEADERS=()
    POST_DATA=""
    NUM_RUNS=1
    WARMUP=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -u|--url)
                TARGET_URL="$2"
                shift 2
                ;;
            -p|--path)
                TARGET_PATH="$2"
                shift 2
                ;;
            -n|--requests)
                NUM_REQUESTS="$2"
                shift 2
                ;;
            -c|--concurrency)
                CONCURRENCY="$2"
                shift 2
                ;;
            -m|--method)
                HTTP_METHOD="$2"
                shift 2
                ;;
            -t|--timeout)
                TIMEOUT="$2"
                shift 2
                ;;
            -H|--header)
                HEADERS+=("$2")
                shift 2
                ;;
            -d|--data)
                POST_DATA="$2"
                shift 2
                ;;
            -o|--output)
                REPORT_DIR="$2"
                shift 2
                ;;
            -r|--runs)
                NUM_RUNS="$2"
                shift 2
                ;;
            -w|--warmup)
                WARMUP=true
                shift
                ;;
            -h|--help)
                usage
                ;;
            *)
                log_error "Opción desconocida: $1"
                usage
                ;;
        esac
    done
    
    if [ -z "${TARGET_URL}" ]; then
        log_error "URL objetivo requerida. Use -u o --url"
        usage
    fi
    
    # Validar método HTTP
    case "${HTTP_METHOD}" in
        GET|POST|PUT|DELETE|PATCH|HEAD|OPTIONS) ;;
        *)
            log_error "Método HTTP inválido: ${HTTP_METHOD}"
            usage
            ;;
    esac
    
    # Construir URL completa
    FULL_URL="${TARGET_URL}${TARGET_PATH}"
}

# Ejecutar warmup
run_warmup() {
    log_info "Ejecutando warmup con 100 peticiones..."
    
    local warmup_args=()
    warmup_args+=("-n" "100")
    warmup_args+=("-c" "10")
    warmup_args+=("-s" "${TIMEOUT}")
    
    for header in "${HEADERS[@]}"; do
        warmup_args+=("-H" "${header}")
    done
    
    if [ -n "${POST_DATA}" ]; then
        if [ -f "${POST_DATA}" ]; then
            warmup_args+=("-p" "${POST_DATA}")
        else
            warmup_args+=("-p" "-")
            echo -n "${POST_DATA}" | ab "${warmup_args[@]}" "${FULL_URL}" > /dev/null 2>&1 || true
            return
        fi
    fi
    
    ab "${warmup_args[@]}" "${FULL_URL}" > /dev/null 2>&1 || true
    log_success "Warmup completado"
}

# Ejecutar test de carga
run_load_test() {
    local run_number="$1"
    local timestamp="$2"
    
    log_info "Ejecutando test de carga #${run_number}"
    log_info "URL: ${FULL_URL}"
    log_info "Método: ${HTTP_METHOD}"
    log_info "Peticiones: ${NUM_REQUESTS}, Concurrencia: ${CONCURRENCY}"
    
    mkdir -p "${REPORT_DIR}"
    
    local output_file="${REPORT_DIR}/run_${run_number}_${timestamp}.txt"
    local csv_file="${REPORT_DIR}/run_${run_number}_${timestamp}.csv"
    
    local ab_args=()
    ab_args+=("-n" "${NUM_REQUESTS}")
    ab_args+=("-c" "${CONCURRENCY}")
    ab_args+=("-s" "${TIMEOUT}")
    ab_args+=("-g" "${csv_file}")
    ab_args+=("-e" "${REPORT_DIR}/run_${run_number}_${timestamp}_percentiles.csv")
    
    # Agregar headers
    for header in "${HEADERS[@]}"; do
        ab_args+=("-H" "${header}")
    done
    
    # Agregar datos POST si aplica
    if [ "${HTTP_METHOD}" = "POST" ] || [ "${HTTP_METHOD}" = "PUT" ] || [ "${HTTP_METHOD}" = "PATCH" ]; then
        if [ -n "${POST_DATA}" ]; then
            if [ -f "${POST_DATA}" ]; then
                ab_args+=("-p" "${POST_DATA}")
            else
                ab_args+=("-p" "-")
            fi
        fi
    fi
    
    # Agregar content-type si hay datos
    if [ -n "${POST_DATA}" ]; then
        ab_args+=("-T" "application/json")
    fi
    
    # Ejecutar ab
    local start_time
    start_time=$(date +%s)
    
    if [ -n "${POST_DATA}" ] && [ ! -f "${POST_DATA}" ]; then
        echo -n "${POST_DATA}" | ab "${ab_args[@]}" "${FULL_URL}" > "${output_file}" 2>&1
    else
        ab "${ab_args[@]}" "${FULL_URL}" > "${output_file}" 2>&1
    fi
    
    local end_time
    end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    log_success "Test completado en ${duration}s"
    
    # Mostrar resultados básicos
    parse_and_display_results "${output_file}"
    
    echo "${output_file}"
}

# Parsear y mostrar resultados
parse_and_display_results() {
    local result_file="$1"
    
    echo ""
    echo "=== Resultados del Test ==="
    
    # Extraer métricas clave
    local rps
    rps=$(grep "Requests per second" "${result_file}" | awk '{print $4}')
    local mean_time
    mean_time=$(grep "Time per request" "${result_file}" | head -n1 | awk '{print $4}')
    local failed
    failed=$(grep "Failed requests:" "${result_file}" | awk '{print $3}')
    local total_time
    total_time=$(grep "Total duration:" "${result_file}" | awk '{print $3}')
    
    echo -e "  ${GREEN}RPS (Requests/seg):${NC} ${rps:-N/A}"
    echo -e "  ${GREEN}Tiempo medio (ms):${NC} ${mean_time:-N/A}"
    echo -e "  ${GREEN}Total time (s):${NC} ${total_time:-N/A}"
    
    if [ "${failed:-0}" -gt 0 ]; then
        echo -e "  ${RED}Requests fallidas: ${failed}${NC}"
    else
        echo -e "  ${GREEN}Requests fallidas: 0${NC}"
    fi
    
    # Mostrar percentiles
    echo ""
    echo "=== Percentiles de Latencia ==="
    grep -E "^\s*(50|75|80|90|95|98|99|100)" "${result_file}" | head -n9 || true
}

# Generar reporte consolidado
generate_summary_report() {
    local timestamp="$1"
    local summary_file="${REPORT_DIR}/summary_${timestamp}.txt"
    
    log_info "Generando reporte consolidado..."
    
    cat > "${summary_file}" << EOF
================================================================================
                    REPORTE DE PRUEBAS DE CARGA - TOMCAT
================================================================================

Fecha: $(date -u +'%Y-%m-%d %H:%M:%S UTC')
URL Objetivo: ${FULL_URL}
Método HTTP: ${HTTP_METHOD}
Peticiones totales: ${NUM_REQUESTS}
Concurrencia: ${CONCURRENCY}
Número de ejecuciones: ${NUM_RUNS}

================================================================================
EOF
    
    # Agregar resultados de cada ejecución
    for run in $(seq 1 ${NUM_RUNS}); do
        local run_file
        run_file=$(ls -t "${REPORT_DIR}/run_${run}_${timestamp}.txt" 2>/dev/null | head -n1)
        
        if [ -n "${run_file}" ]; then
            echo "" >> "${summary_file}"
            echo "--- Ejecución #${run} ---" >> "${summary_file}"
            grep -E "(Requests per second|Time per request|Failed requests|Non-2xx responses|Complete requests|Total duration)" "${run_file}" >> "${summary_file}" 2>/dev/null || true
        fi
    done
    
    echo "" >> "${summary_file}"
    echo "================================================================================" >> "${summary_file}"
    echo "Reporte guardado en: ${summary_file}"
    
    log_success "Reporte consolidado: ${summary_file}"
}

# Función principal
main() {
    echo "=========================================="
    echo "  Script de Pruebas de Carga para Tomcat"
    echo "  Versión: ${SCRIPT_VERSION}"
    echo "=========================================="
    echo ""
    
    check_prerequisites
    parse_arguments "$@"
    
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M%S)
    
    log_info "Reporte directorio: ${REPORT_DIR}"
    
    # Warmup si se solicita
    if [ "${WARMUP}" = true ]; then
        run_warmup
    fi
    
    # Ejecutar tests
    for run in $(seq 1 ${NUM_RUNS}); do
        run_load_test "${run}" "${timestamp}"
        
        # Pausa entre ejecuciones
        if [ "${NUM_RUNS}" -gt 1 ] && [ "${run}" -lt "${NUM_RUNS}" ]; then
            log_info "Pausa de 5 segundos antes de la siguiente ejecución..."
            sleep 5
        fi
    done
    
    # Generar reporte consolidado
    if [ "${NUM_RUNS}" -gt 1 ]; then
        generate_summary_report "${timestamp}"
    fi
    
    echo ""
    log_success "Todas las pruebas completadas"
    log_info "Resultados disponibles en: ${REPORT_DIR}"
}

# Ejecutar main
main "$@"

```
