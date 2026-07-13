# setup.ps1 — Inicializa la metodologia en la rama del proyecto
# Uso: .\metodologia\setup.ps1
# Ejecutar desde la raiz del proyecto (en la rama proyecto/[nombre])

$metodologia = $PSScriptRoot
$proyecto    = Get-Location

# ─── 1. Reglas de Cursor (.cursor/rules/ debe estar en la raiz del workspace) ─
$destRules = Join-Path $proyecto ".cursor\rules"
if (-not (Test-Path $destRules)) {
    New-Item -ItemType Directory -Force -Path $destRules | Out-Null
}
Copy-Item -Path "$metodologia\rules\*.mdc" -Destination $destRules -Force
Write-Host "[OK] Reglas copiadas a .cursor/rules/"

# ─── 2. specs/ dentro de metodologia/ ─────────────────────────────────────────
$destSpecs = Join-Path $metodologia "specs"
if (Test-Path $destSpecs) {
    Write-Host "[SKIP] metodologia/specs/ ya existe, no se sobreescribe"
} else {
    New-Item -ItemType Directory -Force -Path "$destSpecs\historias"   | Out-Null
    New-Item -ItemType Directory -Force -Path "$destSpecs\diseno\diagramas" | Out-Null
    New-Item -ItemType Directory -Force -Path "$destSpecs\tecnologias" | Out-Null

    @"
# Historias completadas del proyecto
Cada archivo = una historia aceptada (US-001-nombre.md).
Las historias en desarrollo viven en metodologia/trabajo/[cambio]/historias/.
"@ | Set-Content "$destSpecs\historias\README.md"

    @"
# Diseño del sistema — fuente de verdad
Refleja el diseño actual del proyecto.
Archivos: arquitectura.md, frontend.md, backend.md
diagramas/ contiene los .mmd generados por controlador/endpoint.
Solo actualizar al cerrar un cambio — aplicar deltas, no reescribir todo.
"@ | Set-Content "$destSpecs\diseno\README.md"

    @"
# Tecnologias vigentes del proyecto
Archivo: stack.md — actualizar al agregar o cambiar una tecnologia.
"@ | Set-Content "$destSpecs\tecnologias\README.md"

    Write-Host "[OK] metodologia/specs/ creada"
}

# ─── 3. trabajo/ dentro de metodologia/ ───────────────────────────────────────
$destTrabajo = Join-Path $metodologia "trabajo"
if (Test-Path "$destTrabajo\archive") {
    Write-Host "[SKIP] metodologia/trabajo/ ya existe, no se sobreescribe"
} else {
    New-Item -ItemType Directory -Force -Path "$destTrabajo\_template\historias" | Out-Null
    New-Item -ItemType Directory -Force -Path "$destTrabajo\_template\diseno\diagramas" | Out-Null
    New-Item -ItemType Directory -Force -Path "$destTrabajo\_template\calidad"   | Out-Null
    New-Item -ItemType Directory -Force -Path "$destTrabajo\_template\pruebas"   | Out-Null
    New-Item -ItemType Directory -Force -Path "$destTrabajo\archive"             | Out-Null

    Copy-Item "$metodologia\trabajo\_template\ESTADO.md" "$destTrabajo\_template\ESTADO.md" -ErrorAction SilentlyContinue

    Write-Host "[OK] metodologia/trabajo/ creada"
}

# ──────────────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "Listo. Proximos pasos:"
Write-Host "  1. Edita metodologia/rules/99-proyecto.mdc con los datos del proyecto"
Write-Host "  2. Los specs viven en:   metodologia/specs/"
Write-Host "  3. Los cambios viven en: metodologia/trabajo/"
Write-Host "  4. Lee metodologia/WORKFLOW.md para el flujo completo"
