# setup.ps1 — Instala la metodologia en el proyecto destino
# Uso: .\metodologia\setup.ps1
# Ejecutar desde la raiz del proyecto destino

$metodologia = $PSScriptRoot
$proyecto = Get-Location

# 1. Copiar reglas a .cursor/rules/
$destRules = Join-Path $proyecto ".cursor\rules"
if (-not (Test-Path $destRules)) {
    New-Item -ItemType Directory -Force -Path $destRules | Out-Null
}
Copy-Item -Path "$metodologia\rules\*.mdc" -Destination $destRules -Force
Write-Host "[OK] Reglas copiadas a .cursor/rules/"

# 2. Crear specs/ en la raiz del proyecto (si no existe)
$destSpecs = Join-Path $proyecto "specs"
if (-not (Test-Path $destSpecs)) {
    Copy-Item -Path "$metodologia\specs" -Destination $destSpecs -Recurse -Force
    Write-Host "[OK] Carpeta specs/ creada en el proyecto"
} else {
    Write-Host "[SKIP] specs/ ya existe, no se sobreescribe"
}

# 3. Crear trabajo/ en la raiz del proyecto (si no existe)
$destTrabajo = Join-Path $proyecto "trabajo"
if (-not (Test-Path $destTrabajo)) {
    Copy-Item -Path "$metodologia\trabajo" -Destination $destTrabajo -Recurse -Force
    Write-Host "[OK] Carpeta trabajo/ creada en el proyecto"
} else {
    Write-Host "[SKIP] trabajo/ ya existe, no se sobreescribe"
}

Write-Host ""
Write-Host "Listo. Siguiente paso:"
Write-Host "  Edita metodologia/rules/99-proyecto.mdc con los datos del proyecto actual"
