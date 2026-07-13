# Flujo de trabajo con el agente

## Estructura de carpetas

### Módulo de metodología (este repo — se copia a cualquier proyecto)

```
metodologia/                     ← módulo independiente, mover a cualquier proyecto
  rules/                         ← reglas del agente (fuente de verdad)
    00-perfil.mdc
    01-fases.mdc
    02-historias.mdc
    03-calidad.mdc
    04-pruebas.mdc
    99-proyecto.mdc              ← único que editas por proyecto/rama
  templates/                     ← plantillas reutilizables
    historias/
    diseno/
    calidad/
    pruebas/
  specs/                         ← estructura base de specs/ (se copia al proyecto)
  trabajo/                       ← estructura base de trabajo/ (se copia al proyecto)
    _template/
    archive/
  setup.ps1                      ← activa todo en el proyecto destino
  WORKFLOW.md
```

### Proyecto destino (después de correr setup.ps1)

```
mi-proyecto/                     ← código del proyecto (sin polución)
  src/
  package.json
  ...
  metodologia/                   ← TODO el contexto vive aquí
    rules/                       ← reglas del agente
    templates/                   ← plantillas
    specs/                       ← creado por setup.ps1 — FUENTE DE VERDAD
      historias/
      diseno/
        diagramas/               ← .mmd por controlador/endpoint
      tecnologias/
    trabajo/                     ← creado por setup.ps1
      _template/
      [nombre-cambio]/           ← cambio activo
      archive/                   ← cambios cerrados
    setup.ps1
    WORKFLOW.md
  .cursor/rules/                 ← creado por setup.ps1 (Cursor requiere aquí)
```

> El proyecto real no se contamina. Todo el contexto de la metodología vive dentro de `metodologia/`.

---

## Flujo completo paso a paso

### 1. Recibir la historia o requerimiento

El usuario le da al agente la historia o descripción del cambio.

**El agente hace primero:**
```
Leer specs/historias/   → ¿ya existe algo similar?
Leer specs/diseno/      → ¿qué arquitectura hay hoy?
Leer specs/tecnologias/ → ¿qué stack está en uso?
```

---

### 2. Activar fases

El agente pregunta:
> "¿Qué fases quieres activar? (historias / diseño / limpieza / pruebas / validación)"

Si el usuario no sabe, el agente sugiere las más relevantes según el tipo de cambio.

---

### 3. Crear la carpeta del cambio

```
trabajo/
  nombre-del-cambio/
    ESTADO.md              ← copiado de trabajo/_template/ESTADO.md
    historias/             ← si fase activa → llenar con template
    diseno/                ← si fase activa → llenar con templates
    calidad/               ← si fase activa → llenar con template
    pruebas/               ← si fase activa → llenar con templates
```

El agente llena cada template con la información del cambio.
El usuario revisa y ajusta antes de implementar.

---

### 4. Implementación

El agente ejecuta las tareas del `ESTADO.md` en orden.
Marca cada tarea completada con `[x]`.
Si encuentra algo inesperado, actualiza el template correspondiente antes de continuar.

---

### 5. Pruebas

Si la fase de pruebas está activa:
- El agente escribe/actualiza los casos en `pruebas/test-case.md`
- Ejecuta las pruebas y documenta resultados
- Si hay fallos, vuelve al paso 4

---

### 6. Validación funcional

El agente verifica cada criterio de aceptación en `pruebas/validation.md`.
Confirma con el usuario que todo está correcto antes de cerrar.

---

### 7. Sincronización con specs/ (cierre del cambio)

**Solo se escriben los deltas — no se reescribe todo.**

| Qué cambió | Dónde actualizar en specs/ |
|-----------|---------------------------|
| Nueva historia aceptada | Copiar `historias/US-xxx.md` → `specs/historias/` |
| Cambio de arquitectura | Actualizar sección en `specs/diseno/arquitectura.md` |
| Nuevos componentes frontend | Actualizar `specs/diseno/frontend.md` |
| Nuevos endpoints o modelos | Actualizar `specs/diseno/backend.md` |
| Nueva tecnología agregada | Actualizar `specs/tecnologias/stack.md` |

**Luego mover el cambio a archive:**
```
trabajo/archive/2026-07-12-nombre-del-cambio/
```

---

## Reglas de sincronización

1. **Nunca reescribir specs/ completo** — solo actualizar lo que cambió
2. **specs/ siempre refleja el sistema actual** — no lo que se planea hacer
3. **trabajo/archive/ es el historial** — no se elimina, solo se archiva
4. **Si hay conflicto** (el spec dice X pero el código hace Y), el agente lo reporta antes de modificar

---

## Ejemplo rápido

```
Usuario: "Quiero agregar login con Google"

Agente:
1. Lee specs/ → no existe módulo de auth aún
2. Activa: historias + diseño backend + diseño tecnologías + pruebas
3. Crea: trabajo/login-google/
4. Llena templates → usuario revisa
5. Implementa el código
6. Corre pruebas → verde
7. Valida contra criterios de aceptación
8. Sync:
   - specs/historias/US-001-login-google.md  (nuevo)
   - specs/diseno/backend.md                 (agrega endpoint /auth/google)
   - specs/tecnologias/stack.md              (agrega passport-google-oauth2)
9. Mueve a: trabajo/archive/2026-07-12-login-google/
```
