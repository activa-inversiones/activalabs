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
