function Write-Utf8 {
    param(
        [string]$Path,
        [string]$Content
    )
    $dir = Split-Path -Parent $Path
    if ($dir -and -not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    Set-Content -Path $Path -Value $Content -Encoding UTF8
}

$base = Join-Path (Get-Location) "12_infrastructure"

$dirs = @(
    "railway",
    "railway\env",
    "runbooks",
    "scripts"
)

New-Item -ItemType Directory -Path $base -Force | Out-Null
foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Path (Join-Path $base $dir) -Force | Out-Null
}

Write-Utf8 (Join-Path $base "README.md") @'
# 12_infrastructure

Infraestructura maestra de ACTIVALABS para producción real.

## Propósito

Este directorio concentra la verdad técnica de despliegue y operación para evitar retrabajo:

- mapa de servicios Railway
- dominios y exposición pública
- entrypoints reales por repositorio
- variables ejemplo por servicio
- orden de despliegue
- runbooks de preproducción, go-live y rollback

## Regla de gobierno

- GitHub = verdad técnica
- Railway = ejecución
- Zoho = operación comercial
- WordPress (activaspa.cl) = frente comercial actual

## Repos actuales observados

- activa-sales-os
- whatsapp-ia-hubspot
- unified-cxm-ads-flow
- motor-permisos-araucania

## Principios

- no romper producción actual
- no rehacer lo que ya funciona
- respetar mezcla real Node.js + Python
- mantener trazabilidad auditable
'@

Write-Utf8 (Join-Path $base "railway\01_service_matrix.md") @'
# 01 Service Matrix

| Servicio Railway | Repo GitHub | Runtime real | Entrypoint real | Exposición | Dominio recomendado | Rol |
|---|---|---|---|---|---|---|
| Postgres | Railway managed | Managed DB | N/A | Interno | N/A | Persistencia central |
| activa-sales-os | activa-sales-os | Node.js | src/server.js | Interno protegido | ops.activalabs.ai | Dashboard, takeover, ingest, trazabilidad |
| whatsapp-ia-hubspot | whatsapp-ia-hubspot | Node.js | index.js | Público | wa.activalabs.ai | WhatsApp API, IA, cotización, takeover |
| unified-cxm-ads-flow | unified-cxm-ads-flow | Node.js | index.js | Público | hooks.activalabs.ai | Webhooks ads / formularios / eventos |
| motor-permisos-araucania | motor-permisos-araucania | Python principal + Node auxiliar | permisos_edificacion_vigentes.py | Interno / worker | sin dominio público | Radar de permisos / leads técnicos |

## Decisiones

- Node.js se mantiene para servicios públicos.
- Python se mantiene para procesos de extracción y worker.
- motor-permisos-araucania no se publica como endpoint público en esta fase.
- no se fusionan repos en esta etapa.
'@

Write-Utf8 (Join-Path $base "railway\02_domain_map.md") @'
# 02 Domain Map

## Dominio comercial actual

- activaspa.cl
- WordPress + campañas + formularios + WhatsApp comercial

## Dominio plataforma

- activalabs.ai
- reservado para la plataforma SaaS

## Subdominios recomendados futuros

- ops.activalabs.ai    -> activa-sales-os
- wa.activalabs.ai     -> whatsapp-ia-hubspot
- hooks.activalabs.ai  -> unified-cxm-ads-flow

## Regla

- activaspa.cl sigue siendo el frente productivo comercial ahora.
- activalabs.ai no se fuerza a producción comercial en esta fase.
- motor-permisos no debe exponerse públicamente.
'@

Write-Utf8 (Join-Path $base "railway\03_deploy_order.md") @'
# 03 Deploy Order

## Orden correcto de despliegue

1. Postgres
2. activa-sales-os
3. whatsapp-ia-hubspot
4. unified-cxm-ads-flow
5. motor-permisos-araucania

## Justificación

- Sales OS debe estar arriba antes de takeover y eventos conversacionales.
- WhatsApp IA depende del plano operativo para trazabilidad completa.
- Unified CXM puede entrar después sin bloquear la conversación comercial.
- motor-permisos no es ruta crítica para ventas de hoy.

## Orden de validación

1. /health de activa-sales-os
2. /health de whatsapp-ia-hubspot
3. /health de unified-cxm-ads-flow
4. prueba de conversación real en WhatsApp
5. prueba de registro en Zoho CRM
6. prueba de takeover humano
'@

Write-Utf8 (Join-Path $base "railway\04_runtime_truth.md") @'
# 04 Runtime Truth

## activa-sales-os

- package.json:
  - start = node src/server.js
- railway.json presente
- usa express + pg
- requiere DATABASE_URL

## whatsapp-ia-hubspot

- package.json:
  - start = node index.js
- railway.json presente
- usa express + openai + zoho
- existe archivo services/salesOsBridge.js
- hallazgo importante:
  - el bridge a Sales OS existe en el repo
  - pero actualmente no se observa integrado al flujo principal de index.js
  - esto se debe corregir en la Modificación 2

## unified-cxm-ads-flow

- package.json:
  - start = node index.js
- servicio Node.js público

## motor-permisos-araucania

- Python principal:
  - permisos_edificacion_vigentes.py
- Node auxiliar:
  - index.js
- requirements.txt presente
- Dockerfile presente
- debe seguir como worker interno en esta etapa
'@

Write-Utf8 (Join-Path $base "railway\env\activa-sales-os.production.env.example") @'
PORT=8080
TZ=America/Santiago
DATABASE_URL=
AUTO_MIGRATE=true
APP_BASE_URL=https://ops.activalabs.ai
DEFAULT_TENANT_ID=activa
DASHBOARD_USER=admin
DASHBOARD_PASS=CAMBIAR_PASSWORD_SEGURA
INGEST_TOKEN=CAMBIAR_TOKEN_INGEST
OPERATOR_API_TOKEN=CAMBIAR_TOKEN_OPERATOR
WHATSAPP_BOT_BASE_URL=https://wa.activalabs.ai
WHATSAPP_BOT_INTERNAL_TOKEN=CAMBIAR_TOKEN_WHATSAPP_INTERNAL
ALLOWED_ORIGIN=https://activaspa.cl
ZOHO_BOOKS_BASE_URL=https://books.zoho.com
'@

Write-Utf8 (Join-Path $base "railway\env\whatsapp-ia-hubspot.production.env.example") @'
PORT=8080
TZ=America/Santiago

WHATSAPP_TOKEN=
PHONE_NUMBER_ID=
VERIFY_TOKEN=
APP_SECRET=
META_GRAPH_VERSION=v22.0

OPENAI_API_KEY=
AI_MODEL_OPENAI=gpt-4o-mini
AI_MODEL_STT=whisper-1

REQUIRE_ZOHO=true
ZOHO_CLIENT_ID=
ZOHO_CLIENT_SECRET=
ZOHO_REFRESH_TOKEN=
ZOHO_API_DOMAIN=https://www.zohoapis.com
ZOHO_ACCOUNTS_DOMAIN=https://accounts.zoho.com
ZOHO_ORG_ID=
ZOHO_DEAL_PHONE_FIELD=WhatsApp_Phone
ZOHO_DEFAULT_ACCOUNT_NAME=Clientes WhatsApp IA
ZOHO_DEFAULT_ITEM_ID=

COMPANY_NAME=ACTIVA SPA
COMPANY_PHONE=
COMPANY_EMAIL=
COMPANY_ADDRESS=Temuco, Chile
COMPANY_WEBSITE=https://activaspa.cl
COMPANY_RUT=

PRICER_MODE=winperfil
WINPERFIL_API_BASE=
WINPERFIL_API_KEY=

SALES_OS_URL=https://ops.activalabs.ai
SALES_OS_INGEST_TOKEN=
SALES_OS_OPERATOR_TOKEN=
OPERATOR_API_TOKEN=

HUMAN_ENABLED=true
HUMAN_HANDOFF_ENABLED=true
TYPING_SIMULATION=true
TONE=humano
TONO=humano
'@

Write-Utf8 (Join-Path $base "railway\env\unified-cxm-ads-flow.production.env.example") @'
PORT=8080
NODE_ENV=production
OPENAI_API_KEY=
META_ACCESS_TOKEN=
META_VERIFY_TOKEN=
META_GRAPH_VERSION=v22.0

DEBUG_API_KEY=
JSON_LIMIT=10mb
URLENCODED_LIMIT=10mb
STATE_FILE_PATH=/data/runtime-state.json
RUNTIME_SAVE_INTERVAL_MS=15000
MAX_AUDIT_ENTRIES=500
DASHBOARD_AUDIT_LIMIT=50
'@

Write-Utf8 (Join-Path $base "railway\env\motor-permisos-araucania.production.env.example") @'
LOG_LEVEL=INFO
OPENAI_API_KEY=

RADAR_STATE_DEFAULT=La Araucania
RADAR_COUNTRY_DEFAULT=Chile
RADAR_MUNICIPIOS=Temuco
RADAR_RUN_MODE=full
RADAR_START_YEAR=2025
RADAR_START_MONTH=1
RADAR_TARGET_YEAR=2026
RADAR_TARGET_MONTH=3
RADAR_USE_AI=true
RADAR_USE_GEOCODING=true
RADAR_GEOCODE_RATE_LIMIT_SEC=1.1
SAT_PROVIDER=esri

ZOHO_CLIENT_ID=
ZOHO_CLIENT_SECRET=
ZOHO_REFRESH_TOKEN=
ZOHO_API_BASE=https://www.zohoapis.com
ZOHO_ACCOUNTS_DOMAIN=https://accounts.zoho.com
ZOHO_MODULE=Leads
ZOHO_DUPLICATE_FIELD=Radar_UID
ZOHO_LEAD_UID_FIELD=Radar_UID
ZOHO_LEAD_ROL_FIELD=Rol_Avaluo
ZOHO_LEAD_M2_FIELD=M2_Construidos
ZOHO_LEAD_LAT_FIELD=Geo_Lat
ZOHO_LEAD_LNG_FIELD=Geo_Lng
ZOHO_LEAD_SAT_FIELD=Satellite_URL
ZOHO_DEALS_MODULE=Deals
ZOHO_DEALS_ROL_FIELD=Rol_SII
ZOHO_DEALS_STAGE_FIELD=Stage
ZOHO_DEALS_STAGE_CLOSED_LOST=Perdido y cerrado para la competencia
'@

Write-Utf8 (Join-Path $base "runbooks\01_preproduccion_checklist.md") @'
# 01 Preproduccion Checklist

## No tocar todavía

- no cambiar activaspa.cl como frente comercial
- no cambiar rutas webhook activas
- no exponer motor-permisos públicamente
- no subir secretos reales al repo

## Validaciones técnicas

- Sales OS responde /health
- WhatsApp IA responde /health
- Unified CXM responde /health
- Postgres accesible
- variables cargadas en Railway
- GitHub solo tiene *.env.example

## Validaciones de negocio

- Zoho CRM sigue recibiendo Posibles clientes
- takeover humano disponible
- WordPress sigue operativo
- campañas apuntan a destino correcto
'@

Write-Utf8 (Join-Path $base "runbooks\02_go_live_checklist.md") @'
# 02 Go Live Checklist

1. Confirmar backup mínimo de WordPress y puntos críticos.
2. Confirmar Postgres online.
3. Confirmar activa-sales-os online.
4. Confirmar whatsapp-ia-hubspot online.
5. Confirmar unified-cxm-ads-flow online.
6. Ejecutar prueba real desde WhatsApp.
7. Verificar creación o actualización en Zoho CRM.
8. Verificar takeover humano.
9. Revisar logs los primeros 30 minutos.
10. Recién después escalar campañas.
'@

Write-Utf8 (Join-Path $base "runbooks\03_rollback_checklist.md") @'
# 03 Rollback Checklist

## Condiciones de rollback

- falla webhook principal
- deja de responder WhatsApp
- Zoho no registra
- takeover no funciona
- error crítico tras cambio reciente

## Acciones

1. revertir último deploy del servicio afectado
2. restaurar variables previas si hubo cambios
3. no tocar WordPress ni Zoho si no son el origen
4. registrar el incidente
5. dejar evidencia de causa y corrección
'@

Write-Utf8 (Join-Path $base "scripts\validar-infra-railway.ps1") @'
$root = Split-Path -Parent $PSScriptRoot

$required = @(
    "README.md",
    "railway\01_service_matrix.md",
    "railway\02_domain_map.md",
    "railway\03_deploy_order.md",
    "railway\04_runtime_truth.md",
    "railway\env\activa-sales-os.production.env.example",
    "railway\env\whatsapp-ia-hubspot.production.env.example",
    "railway\env\unified-cxm-ads-flow.production.env.example",
    "railway\env\motor-permisos-araucania.production.env.example",
    "runbooks\01_preproduccion_checklist.md",
    "runbooks\02_go_live_checklist.md",
    "runbooks\03_rollback_checklist.md"
)

$missing = @()

foreach ($rel in $required) {
    $full = Join-Path $root $rel
    if (-not (Test-Path $full)) {
        $missing += $rel
    }
}

if ($missing.Count -gt 0) {
    Write-Host "Faltan archivos en 12_infrastructure:" -ForegroundColor Red
    $missing | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
    exit 1
}

Write-Host "Estructura 12_infrastructure validada correctamente." -ForegroundColor Green
Write-Host "Siguiente paso: Modificacion 2 sobre whatsapp-ia-hubspot." -ForegroundColor Yellow
'@

Write-Host "12_infrastructure actualizada correctamente con contenido real." -ForegroundColor Green