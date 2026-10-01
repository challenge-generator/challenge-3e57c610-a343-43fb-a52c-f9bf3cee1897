# Optimización de Servidores de Aplicación

Tu equipo de operaciones en la nube ha identificado cuellos de botella en el rendimiento de los servidores de aplicación Apache Tomcat utilizados en la plataforma de banca digital. El objetivo es implementar y optimizar servidores de aplicación para mejorar el rendimiento y la escalabilidad del sistema.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Manejo de Middleware |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 15 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración Inicial del Servidor

**Objetivo:** Configurar un servidor de aplicación Apache Tomcat para soportar las cargas de trabajo actuales.

**Tiempo estimado:** 5 horas

**Instrucciones:**

- Identifica las especificaciones de hardware y software necesarias para la configuración inicial del servidor.
- Configura el servidor para manejar un mínimo de 10 000 solicitudes por minuto con una latencia promedio menor a 500ms.

**Entregable:** Servidor de aplicación configurado y operativo.

<details>
<summary>Pistas de conocimiento</summary>

- Considera las limitaciones de memoria y CPU al configurar el servidor.
- Explora diferentes configuraciones de hilos y conexiones para encontrar el equilibrio óptimo.

</details>

### Fase 2: Optimización del Rendimiento

**Objetivo:** Optimizar el rendimiento del servidor de aplicación para manejar cargas de trabajo más altas.

**Tiempo estimado:** 5 horas

**Instrucciones:**

- Identifica áreas de mejora en la configuración actual del servidor.
- Aplica técnicas de optimización para reducir la latencia y aumentar la capacidad de manejo de solicitudes.

**Entregable:** Servidor de aplicación optimizado con mejoras documentadas.

<details>
<summary>Pistas de conocimiento</summary>

- Considera la implementación de caché y pooling de conexiones.
- Explora la configuración de garbage collection y tuning de JVM.

</details>

### Fase 3: Evaluación y Documentación

**Objetivo:** Evaluar el rendimiento del servidor optimizado y documentar las mejoras realizadas.

**Tiempo estimado:** 5 horas

**Instrucciones:**

- Realiza pruebas de carga para evaluar el rendimiento del servidor optimizado.
- Documenta las mejoras realizadas y los resultados obtenidos.

**Entregable:** Informe de evaluación y documentación de mejoras.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza herramientas de pruebas de carga para medir el rendimiento.
- Documenta detalladamente las configuraciones y mejoras aplicadas.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es un servidor de aplicación y cuál es su rol en una plataforma de banca digital?
- **paraQueSirve**: ¿Para qué sirve la optimización de un servidor de aplicación en términos de rendimiento y escalabilidad?
- **comoSeUsa**: ¿Cómo se usa la configuración y tuning de JVM para optimizar el rendimiento de un servidor de aplicación?
- **erroresComunes**: ¿Cuáles son los errores comunes al configurar y optimizar un servidor de aplicación y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica la optimización de un servidor de aplicación y cómo se justifican estas decisiones en términos de rendimiento y escalabilidad?

## Criterios de Evaluacion

- Configuración inicial del servidor de aplicación.
- Optimización del rendimiento del servidor de aplicación.
- Evaluación y documentación de las mejoras realizadas.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
