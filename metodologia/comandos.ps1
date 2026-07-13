# comandos.ps1 - Menu de acciones de la metodologia
# Uso: powershell -ExecutionPolicy Bypass -File "metodologia\comandos.ps1"

$metodologia = $PSScriptRoot

function Show-Menu {
    Clear-Host
    Write-Host "=============================================="
    Write-Host "  METODOLOGIA - MENU DE COMANDOS"
    Write-Host "=============================================="
    Write-Host ""
    $proyectoFile = Join-Path $metodologia "rules\99-proyecto.mdc"
    if (Test-Path $proyectoFile) {
        $nombre = (Get-Content $proyectoFile | Select-String "Nombre:") -replace ".*Nombre:\s*", ""
        $rama = git branch --show-current 2>$null
        Write-Host "  Proyecto : $nombre"
        Write-Host "  Rama     : $rama"
    }
    Write-Host ""
    Write-Host "----------------------------------------------"
    Write-Host "  [1] Nuevo cambio"
    Write-Host "  [2] Ver cambios activos"
    Write-Host "  [3] Cerrar cambio"
    Write-Host "----------------------------------------------"
    Write-Host "  [4] Ver historias     specs/historias/"
    Write-Host "  [5] Ver diseno        specs/diseno/"
    Write-Host "  [6] Ver diagramas     specs/diseno/diagramas/"
    Write-Host "  [7] Ver tecnologias   specs/tecnologias/"
    Write-Host "----------------------------------------------"
    Write-Host "  [8] Editar config proyecto"
    Write-Host "  [9] Ver workflow"
    Write-Host "  [0] Salir"
    Write-Host "=============================================="
}

function Nuevo-Cambio {
    Write-Host ""
    $nombre = Read-Host "Nombre del cambio"
    $nombre = $nombre.Trim().ToLower() -replace " ", "-"
    if ([string]::IsNullOrEmpty($nombre)) {
        Write-Host "[ERROR] El nombre no puede estar vacio."
        return
    }
    $destCambio = Join-Path $metodologia "trabajo\$nombre"
    if (Test-Path $destCambio) {
        Write-Host "[SKIP] El cambio ya existe."
        return
    }
    $template = Join-Path $metodologia "trabajo\_template"
    New-Item -ItemType Directory -Force -Path "$destCambio\historias" | Out-Null
    New-Item -ItemType Directory -Force -Path "$destCambio\diseno\diagramas" | Out-Null
    New-Item -ItemType Directory -Force -Path "$destCambio\calidad" | Out-Null
    New-Item -ItemType Directory -Force -Path "$destCambio\pruebas" | Out-Null
    Copy-Item "$template\ESTADO.md" "$destCambio\ESTADO.md" -ErrorAction SilentlyContinue
    $estadoFile = "$destCambio\ESTADO.md"
    if (Test-Path $estadoFile) {
        (Get-Content $estadoFile) -replace "\[nombre-cambio\]", $nombre | Set-Content $estadoFile
        $fecha = Get-Date -Format "yyyy-MM-dd"
        (Get-Content $estadoFile) -replace "\[fecha\]", $fecha | Set-Content $estadoFile
    }
    Write-Host "[OK] Cambio creado en metodologia/trabajo/$nombre/"
}

function Ver-CambiosActivos {
    $trabajoDir = Join-Path $metodologia "trabajo"
    $cambios = Get-ChildItem $trabajoDir -Directory | Where-Object { $_.Name -ne "_template" -and $_.Name -ne "archive" }
    Write-Host ""
    if ($cambios.Count -eq 0) {
        Write-Host "  No hay cambios activos."
    } else {
        foreach ($c in $cambios) {
            Write-Host "  -> $($c.Name)"
        }
    }
}

function Cerrar-Cambio {
    $trabajoDir = Join-Path $metodologia "trabajo"
    $cambios = Get-ChildItem $trabajoDir -Directory | Where-Object { $_.Name -ne "_template" -and $_.Name -ne "archive" }
    if ($cambios.Count -eq 0) {
        Write-Host "  No hay cambios activos."
        return
    }
    for ($i = 0; $i -lt $cambios.Count; $i++) {
        Write-Host "  [$($i+1)] $($cambios[$i].Name)"
    }
    $sel = Read-Host "Numero del cambio a cerrar"
    $idx = [int]$sel - 1
    if ($idx -lt 0 -or $idx -ge $cambios.Count) {
        Write-Host "[ERROR] Invalido."
        return
    }
    $cambio = $cambios[$idx]
    $fecha = Get-Date -Format "yyyy-MM-dd"
    $dest = Join-Path $metodologia "trabajo\archive\$fecha-$($cambio.Name)"
    Move-Item $cambio.FullName $dest
    Write-Host "[OK] Archivado en trabajo/archive/$fecha-$($cambio.Name)/"
}

function Abrir-Carpeta {
    param($ruta)
    $full = Join-Path $metodologia $ruta
    if (Test-Path $full) {
        Get-ChildItem $full -Recurse -File | ForEach-Object {
            Write-Host "  -> $($_.FullName.Replace($metodologia, 'metodologia'))"
        }
    } else {
        Write-Host "  La carpeta no existe aun: $ruta"
    }
}

do {
    Show-Menu
    $opcion = Read-Host "Selecciona una opcion"
    switch ($opcion) {
        "1" { Nuevo-Cambio }
        "2" { Ver-CambiosActivos }
        "3" { Cerrar-Cambio }
        "4" { Abrir-Carpeta "specs\historias" }
        "5" { Abrir-Carpeta "specs\diseno" }
        "6" { Abrir-Carpeta "specs\diseno\diagramas" }
        "7" { Abrir-Carpeta "specs\tecnologias" }
        "8" { Write-Host "  Abre: metodologia/rules/99-proyecto.mdc" }
        "9" { Write-Host "  Abre: metodologia/WORKFLOW.md" }
        "0" { Write-Host "Hasta luego." }
        default { Write-Host "  Opcion no valida." }
    }
    if ($opcion -ne "0") {
        Read-Host "Presiona Enter para continuar"
    }
} while ($opcion -ne "0")