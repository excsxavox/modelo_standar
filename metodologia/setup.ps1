# setup.ps1 — Instala los módulos de metodología en .cursor/rules/
# Uso: .\metodologia\setup.ps1
# Ejecutar desde la raíz del proyecto destino

$origen = Join-Path $PSScriptRoot "modulos"
$destino = Join-Path (Get-Location) ".cursor\rules"

if (-not (Test-Path $destino)) {
    New-Item -ItemType Directory -Force -Path $destino | Out-Null
    Write-Host "Carpeta .cursor/rules/ creada."
}

Copy-Item -Path "$origen\*.mdc" -Destination $destino -Force
Write-Host "Modulos copiados a $destino"
Write-Host ""
Write-Host "Siguiente paso: edita la Seccion 6 en .cursor/rules/99-proyecto.mdc"
