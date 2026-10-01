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