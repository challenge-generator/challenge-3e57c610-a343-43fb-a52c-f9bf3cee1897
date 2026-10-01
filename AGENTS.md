# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Optimización de Servidores de Aplicación**.

| | |
|---|---|
| Tema | Manejo de Middleware |
| Nivel | senior-l2 |
| Chapter | Cloud Ops |
| Especialidad | AWS |
| Stack | HCL / Terraform |
| Patron arquitectonico | modular con separación de ambientes y backend remoto para estado |
| Tiempo estimado | 15 horas |

## Receta del stack

Esqueleto obligatorio:

- `main.tf, variables.tf, outputs.tf y providers.tf en la raiz`
- `modules/ con al menos un modulo propio`
- `environments/{dev,qa,prod}/terraform.tfvars`
- `backend.tf con el estado remoto`
- `README.md con el diagrama de la topologia`

Trampas conocidas:

- `required_version` de Terraform se declara como RANGO (`>= 1.5`), nunca como version exacta (`= 1.7.0` ni `"1.7.0"`). Pineado exacto, el proyecto no corre con ninguna otra version instalada y el participante no puede ni inicializarlo.
- Lo mismo con los providers: `version = "~> 5.0"`, no una version exacta.
- Cada variable de `variables.tf` lleva su valor en `environments/{env}/terraform.tfvars`, no un `default` en la declaracion.

Dependencias:

- hashicorp/aws ~> 5.0
- cloudposse/tomcat/aws 0.10.0
- terraform-aws-modules/vpc/aws 5.0.0
- aws-cli n/a

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `terraform init -backend=false && terraform validate && terraform fmt -check` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `terraform init -backend=false && terraform validate && terraform fmt -check` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Configuración Inicial del Servidor**: Servidor de aplicación configurado y operativo.
- **Fase 2 — Optimización del Rendimiento**: Servidor de aplicación optimizado con mejoras documentadas.
- **Fase 3 — Evaluación y Documentación**: Informe de evaluación y documentación de mejoras.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Lo que falta y tenes que completar

No se detectaron huecos: estan los archivos declarados, el boilerplate del stack y ninguna referencia quedo colgando. Igual corre el comando de verificacion — que los archivos existan no garantiza que compilen.

### Presentes (17)

- `variables.tf`
- `providers.tf`
- `modules/tomcat_server/variables.tf`
- `modules/network_infra/variables.tf`
- `main.tf`
- `outputs.tf`
- `backend.tf`
- `README.md`
- `modules/tomcat_server/main.tf`
- `modules/tomcat_server/outputs.tf`
- `modules/network_infra/main.tf`
- `modules/network_infra/outputs.tf`
- `environments/dev/terraform.tfvars`
- `environments/qa/terraform.tfvars`
- `environments/prod/terraform.tfvars`
- `scripts/configure_tomcat.sh`
- `scripts/load_test.sh`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `modules/tomcat_server`
- `modules/network_infra`
- `environments/dev`
- `environments/qa`
- `environments/prod`

## Verificacion

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **modular con separación de ambientes y backend remoto para estado**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Cloud Ops, Especialidad Analista, Seniority Senior
- Brecha que el reto ataca: Implementa soluciones de servidores de aplicación como Apache Tomcat o IBM Websphere de manera integral y realiza optimizaciones sobre las mismas
- Mision: Candidato con experiencia en infraestructura y operaciones en la nube, enfocado en optimización de servidores

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
