$base = "C:\Users\activalabs\11_prompt_operativo"

# Prompt Maestro
@"
# Prompt Maestro ISO SaaS v2

Actúa como arquitecto senior de software y auditor técnico.

Objetivo:
Evaluar y diseñar soluciones SaaS considerando:

- Arquitectura
- Seguridad
- Operación
- Cumplimiento ISO
- Escalabilidad
- Riesgos

Siempre distinguir:
Hechos
Supuestos
Vacíos

La respuesta debe incluir:

1. Diagnóstico
2. Riesgos
3. Recomendaciones
4. Evidencia requerida
5. Prioridad de implementación
"@ | Set-Content "$base\Prompt_Maestro_ISO_SaaS_v2.md"



# Bloque de Contexto
@"
# Bloque de Contexto y Solicitud v2

Proyecto: ACTIVAlabs

Tipo de sistema:
SaaS multi-tenant.

Infraestructura:
GitHub + Railway

Stack tecnológico:

Backend:
Node.js

Base de datos:
PostgreSQL

Frontend:
React / Next.js

Objetivo:
Construir una plataforma SaaS modular para ventas,
marketing, servicio al cliente y automatización con IA.

Vertical inicial:
Ventanas y puertas (Fenestration).

Integraciones principales:

Zoho CRM
Zoho Projects
WhatsApp API
Meta Ads
Google Ads
TikTok Ads
"@ | Set-Content "$base\Bloque_Contexto_y_Solicitud_v2.md"



# Matriz de Control
@"
# Matriz de Control y Evidencia

ID | Control | Evidencia | Estado
---|---|---|---
CTRL-001 | Control de accesos | RBAC implementado | Pendiente
CTRL-002 | Registro de auditoría | Logs centralizados | Pendiente
CTRL-003 | Gestión de cambios | Git versionado | Implementado
CTRL-004 | Copias de seguridad | Backup base datos | Pendiente
CTRL-005 | Gestión de incidentes | Runbooks | Pendiente
CTRL-006 | Cumplimiento datos | Política privacidad | Pendiente
"@ | Set-Content "$base\Matriz_de_Control_y_Evidencia_SaaS_ISO.md"



# Guía de Uso
@"
# Guía de Uso Rápido

1 Describir el contexto del proyecto.
2 Aplicar Prompt Maestro.
3 Registrar hallazgos en la matriz de control.
4 Documentar decisiones técnicas.
5 Actualizar evidencia de cumplimiento.

Esto permite:

- trazabilidad
- auditoría ISO
- mejora continua
"@ | Set-Content "$base\Guia_de_Uso_Rapido_Prompt_ISO_SaaS.md"


Write-Host "Archivos creados correctamente en 11_prompt_operativo"