# comandos.ps1 — Menu de acciones de la metodologia
# Uso: .\metodologia\comandos.ps1
# Ejecutar desde la raiz del proyecto

$metodologia = $PSScriptRoot

function Show-Menu {
    Clear-Host
    Write-Host "=============================================="
    Write-Host "  METODOLOGIA — MENU DE COMANDOS"
    Write-Host "=============================================="
    Write-Host ""

    # Mostrar proyecto activo
    $proyectoFile = Join-Path $metodologia "rules\99-proyecto.mdc"
    if (Test-Path $proyectoFile) {
        $nombre = (Get-Content $proyectoFile | Select-String "Nombre:") -replace ".*Nombre:\s*", ""
        $rama   = git branch --show-current 2>$null
        Write-Host "  Proyecto : $nombre"
        Write-Host "  Rama     : $rama"
    }

    Write-Host ""
    Write-Host "----------------------------------------------"
    Write-Host "  CAMBIOS"
    Write-Host "----------------------------------------------"
    Write-Host "  [1] Nuevo cambio          <- iniciar una historia o tarea"
    Write-Host "  [2] Ver cambios activos   <- listar trabajo en curso"
    Write-Host "  [3] Cerrar cambio         <- sincronizar y archivar"
    Write-Host ""
    Write-Host "----------------------------------------------"
    Write-Host "  SPECS (fuente de verdad)"
    Write-Host "----------------------------------------------"
    Write-Host "  [4] Ver historias         <- specs/historias/"
    Write-Host "  [5] Ver diseno            <- specs/diseno/"
    Write-Host "  [6] Ver diagramas         <- specs/diseno/diagramas/"
    Write-Host "  [7] Ver tecnologias       <- specs/tecnologias/"
    Write-Host ""
    Write-Host "----------------------------------------------"
    Write-Host "  CONFIGURACION"
    Write-Host "----------------------------------------------"
    Write-Host "  [8] Editar config proyecto  <- 99-proyecto.mdc"
    Write-Host "  [9] Ver workflow            <- WORKFLOW.md"
    Write-Host "  [0] Salir"
    Write-Host ""
    Write-Host "=============================================="
}

function Nuevo-Cambio {
    Write-Host ""
    $nombre = Read-Host "Nombre del cambio (ej: login-google, carrito-compras)"
    $nombre = $nombre.Trim().ToLower() -replace " ", "-"
    if ([string]::IsNullOrEmpty($nombre)) {
        Write-Host "[ERROR] El nombre no puede estar vacio."
        return
    }

    $destCambio = Join-Path $metodologia "trabajo\$nombre"
    if (Test-Path $destCambio) {
        Write-Host "[SKIP] El cambio '$nombre' ya existe en metodologia/trabajo/"
        return
    }

    # Copiar estructura desde _template
    $template = Join-Path $metodologia "trabajo\_template"
    New-Item -ItemType Directory -Force -Path "$destCambio\historias"         | Out-Null
    New-Item -ItemType Directory -Force -Path "$destCambio\diseno\diagramas"  | Out-Null
    New-Item -ItemType Directory -Force -Path "$destCambio\calidad"           | Out-Null
    New-Item -ItemType Directory -Force -Path "$destCambio\pruebas"           | Out-Null
    Copy-Item "$template\ESTADO.md" "$destCambio\ESTADO.md" -ErrorAction SilentlyContinue

    # Actualizar ESTADO.md con el nombre
    $estadoFile = "$destCambio\ESTADO.md"
    (Get-Content $estadoFile) -replace "\[nombre-cambio\]", $nombre | Set-Content $estadoFile
    $fecha = Get-Date -Format "yyyy-MM-dd"
    (Get-Content $estadoFile) -replace "\[fecha\]", $fecha | Set-Content $estadoFile

    Write-Host ""
    Write-Host "[OK] Cambio '$nombre' creado en metodologia/trabajo/$nombre/"
    Write-Host ""
    Write-Host "ESTRUCTURA CREADA:"
    Write-Host "  metodologia/trabajo/$nombre/ESTADO.md        <- tracker de progreso"
    Write-Host "  metodologia/trabajo/$nombre/historias/        <- llenar con user-story"
    Write-Host "  metodologia/trabajo/$nombre/diseno/           <- llenar con diseno"
    Write-Host "  metodologia/trabajo/$nombre/diseno/diagramas/ <- .mmd por endpoint"
    Write-Host "  metodologia/trabajo/$nombre/calidad/          <- cleanup si aplica"
    Write-Host "  metodologia/trabajo/$nombre/pruebas/          <- test-case, validation"
    Write-Host ""
    Write-Host "SIGUIENTE PASO:"
    Write-Host "  Abre ESTADO.md y activa las fases que necesitas"
    Write-Host "  Usa las plantillas en metodologia/templates/"
}

function Ver-CambiosActivos {
    $trabajoDir = Join-Path $metodologia "trabajo"
    $cambios = Get-ChildItem $trabajoDir -Directory | Where-Object { $_.Name -ne "_template" -and $_.Name -ne "archive" }
    Write-Host ""
    if ($cambios.Count -eq 0) {
        Write-Host "  No hay cambios activos en metodologia/trabajo/"
    } else {
        Write-Host "  CAMBIOS ACTIVOS:"
        foreach ($c in $cambios) {
            $estadoFile = Join-Path $c.FullName "ESTADO.md"
            $pendientes = 0
            $completados = 0
            if (Test-Path $estadoFile) {
                $pendientes  = (Get-Content $estadoFile | Select-String "\[ \]").Count
                $completados = (Get-Content $estadoFile | Select-String "\[x\]").Count
            }
            Write-Host "  -> $($c.Name)   [completados: $completados | pendientes: $pendientes]"
        }
    }
}

function Cerrar-Cambio {
    $trabajoDir = Join-Path $metodologia "trabajo"
    $cambios = Get-ChildItem $trabajoDir -Directory | Where-Object { $_.Name -ne "_template" -and $_.Name -ne "archive" }
    if ($cambios.Count -eq 0) {
        Write-Host "  No hay cambios activos para cerrar."
        return
    }
    Write-Host ""
    Write-Host "  Cambios activos:"
    for ($i = 0; $i -lt $cambios.Count; $i++) {
        Write-Host "  [$($i+1)] $($cambios[$i].Name)"
    }
    $sel = Read-Host "Selecciona el numero del cambio a cerrar"
    $idx = [int]$sel - 1
    if ($idx -lt 0 -or $idx -ge $cambios.Count) {
        Write-Host "[ERROR] Seleccion invalida."
        return
    }
    $cambio = $cambios[$idx]
    $fecha  = Get-Date -Format "yyyy-MM-dd"
    $dest   = Join-Path $metodologia "trabajo\archive\$fecha-$($cambio.Name)"
    Move-Item $cambio.FullName $dest
    Write-Host ""
    Write-Host "[OK] Cambio archivado en:"
    Write-Host "  metodologia/trabajo/archive/$fecha-$($cambio.Name)/"
    Write-Host ""
    Write-Host "SIGUIENTE PASO — sincronizar specs/:"
    Write-Host "  Copia los artefactos relevantes a metodologia/specs/"
    Write-Host "  Solo los deltas — no reescribas lo que no cambio"
}

function Abrir-Carpeta($ruta) {
    $full = Join-Path $metodologia $ruta
    if (Test-Path $full) {
        Write-Host ""
        Write-Host "  Contenido de metodologia/$ruta :"
        Get-ChildItem $full -Recurse -File | ForEach-Object {
            Write-Host "  -> $($_.FullName.Replace($metodologia, 'metodologia'))"
        }
    } else {
        Write-Host "  La carpeta metodologia/$ruta no existe aun."
        Write-Host "  Se crea al cerrar el primer cambio que la afecte."
    }
}

# ─── Loop principal ───────────────────────────────────────────────────────────
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
        "8" {
            Write-Host ""
            Write-Host "  Abre el archivo:"
            Write-Host "  -> metodologia/rules/99-proyecto.mdc"
        }
        "9" {
            Write-Host ""
            Write-Host "  Abre el archivo:"
            Write-Host "  -> metodologia/WORKFLOW.md"
        }
        "0" { Write-Host "Hasta luego." }
        default { Write-Host "  Opcion no valida, intenta de nuevo." }
    }

    if ($opcion -ne "0") {
        Write-Host ""
        Read-Host "Presiona Enter para volver al menu"
    }

} while ($opcion -ne "0")
