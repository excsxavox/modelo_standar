# setup.ps1 — Inicializa la metodologia en la rama del proyecto
# Uso: .\metodologia\setup.ps1
# Ejecutar desde la raiz del proyecto (en la rama proyecto/[nombre])

$metodologia = $PSScriptRoot
$proyecto    = Get-Location

# ─── 1. Reglas de Cursor ────────────────────────────────────────────────────
$destRules = Join-Path $proyecto ".cursor\rules"
if (-not (Test-Path $destRules)) {
    New-Item -ItemType Directory -Force -Path $destRules | Out-Null
}
Copy-Item -Path "$metodologia\rules\*.mdc" -Destination $destRules -Force
Write-Host "[OK] Reglas copiadas a .cursor/rules/"

# ─── 2. Carpeta specs/ ──────────────────────────────────────────────────────
$destSpecs = Join-Path $proyecto "specs"
if (Test-Path $destSpecs) {
    Write-Host "[SKIP] specs/ ya existe, no se sobreescribe"
} else {
    New-Item -ItemType Directory -Force -Path "$destSpecs\historias"  | Out-Null
    New-Item -ItemType Directory -Force -Path "$destSpecs\diseno"     | Out-Null
    New-Item -ItemType Directory -Force -Path "$destSpecs\tecnologias"| Out-Null

    @"
# Historias de usuario — fuente de verdad
Historias completadas del proyecto. Cada archivo = una historia (US-001-nombre.md).
Las historias en desarrollo viven en trabajo/[cambio]/historias/.
"@ | Set-Content "$destSpecs\historias\README.md"

    @"
# Diseño del sistema — fuente de verdad
Refleja el diseño actual (lo que ya existe y funciona).
Archivos: arquitectura.md, frontend.md, backend.md
Solo se actualiza al cerrar un cambio — aplicar deltas, no reescribir todo.
"@ | Set-Content "$destSpecs\diseno\README.md"

    @"
# Tecnologías — fuente de verdad
Stack tecnológico vigente del proyecto.
Archivo: stack.md — actualizar al agregar o cambiar una tecnología.
"@ | Set-Content "$destSpecs\tecnologias\README.md"

    Write-Host "[OK] Carpeta specs/ creada"
}

# ─── 3. Carpeta trabajo/ ────────────────────────────────────────────────────
$destTrabajo = Join-Path $proyecto "trabajo"
if (Test-Path $destTrabajo) {
    Write-Host "[SKIP] trabajo/ ya existe, no se sobreescribe"
} else {
    New-Item -ItemType Directory -Force -Path "$destTrabajo\_template\historias" | Out-Null
    New-Item -ItemType Directory -Force -Path "$destTrabajo\_template\diseno"    | Out-Null
    New-Item -ItemType Directory -Force -Path "$destTrabajo\_template\calidad"   | Out-Null
    New-Item -ItemType Directory -Force -Path "$destTrabajo\_template\pruebas"   | Out-Null
    New-Item -ItemType Directory -Force -Path "$destTrabajo\archive"             | Out-Null

    Copy-Item "$metodologia\trabajo\_template\ESTADO.md" "$destTrabajo\_template\ESTADO.md"

    Write-Host "[OK] Carpeta trabajo/ creada"
}

# ────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "Listo. Proximos pasos:"
Write-Host "  1. Edita metodologia/rules/99-proyecto.mdc con los datos del proyecto"
Write-Host "  2. Usa metodologia/templates/ para llenar los artefactos de cada cambio"
Write-Host "  3. Lee metodologia/WORKFLOW.md para el flujo completo"
