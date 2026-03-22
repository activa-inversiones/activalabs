$base = "C:\Users\activalabs\12_infrastructure"

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

"# Infrastructure Railway ACTIVALABS" | Out-File "$base\README.md"

"# Service Matrix" | Out-File "$base\railway\01_service_matrix.md"

"# Domain Map" | Out-File "$base\railway\02_domain_map.md"

"# Deploy Order" | Out-File "$base\railway\03_deploy_order.md"

"# Runbook Preproduccion" | Out-File "$base\runbooks\01_preproduccion_checklist.md"

"# Runbook Go Live" | Out-File "$base\runbooks\02_go_live_checklist.md"

"# Runbook Rollback" | Out-File "$base\runbooks\03_rollback_checklist.md"

Write-Host "Infraestructura Railway creada correctamente"