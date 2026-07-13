# Metodología Personal de Desarrollo — Edison

Repositorio independiente que contiene las reglas y metodología para trabajar con el agente de Cursor en cualquier proyecto.

## Estructura

```
metodologia/
  rules/               ← fuente de verdad de las reglas (editar aquí)
    00-perfil.mdc
    01-fases.mdc
    02-historias.mdc
    03-calidad.mdc
    04-pruebas.mdc
    99-proyecto.mdc    ← única sección que cambia por proyecto
  templates/           ← plantillas reutilizables
    user-story.md
    design.md
    cleanup.md
    test-case.md
    validation.md
  setup.ps1            ← activa las reglas en el proyecto destino
README.md
```

> Las reglas viven en `metodologia/rules/`. El script `setup.ps1` las copia a `.cursor/rules/` para que Cursor las lea.

## Cómo funciona

| Módulo | Contenido | ¿Cambia? |
|--------|-----------|----------|
| `00-perfil.mdc` | Nombre, idioma, estilo de respuesta | No |
| `01-fases.mdc` | Fases opcionales de desarrollo | No |
| `02-historias.mdc` | Formato de historias de usuario | No |
| `03-calidad.mdc` | Estándares de calidad y limpieza | No |
| `04-pruebas.mdc` | Pruebas unitarias y validación funcional | No |
| `99-proyecto.mdc` | Config del proyecto activo | **Solo esta** |

## Uso por proyecto

### Nuevo proyecto

```powershell
git checkout main
git checkout -b proyecto/nombre-del-proyecto
```

Edita solo `metodologia/rules/99-proyecto.mdc`:

```markdown
# Proyecto actual
- Nombre: Mi App
- Stack: React, Node.js, PostgreSQL
- Descripción: Plataforma de gestión de tareas
- Entornos: dev / prod
- Notas: API REST en /api/v1, autenticación con JWT
```

Luego activa las reglas en el proyecto:

```powershell
.\metodologia\setup.ps1
```

### Listar proyectos activos

```powershell
git branch
```

### Actualizar la metodología base

```powershell
git checkout main
# editar metodologia/rules/ (módulos 00-04 únicamente)
git add .
git commit -m "mejora: [descripción del cambio]"

# Aplicar la mejora a un proyecto existente
git checkout proyecto/nombre-del-proyecto
git merge main
.\metodologia\setup.ps1   # re-activar reglas actualizadas
```

## Ramas disponibles

- `main` — Base genérica de la metodología
- `proyecto/*` — Una rama por cada proyecto activo

## Fases disponibles

Al iniciar un cambio, el agente preguntará qué fases activar:

- **Historias de usuario** — Para requerimientos nuevos o poco claros
- **Diseño** — Para cambios con impacto en arquitectura
- **Limpieza de código** — Para resolver deuda técnica antes de implementar
- **Calidad de código** — Para revisión de estándares
- **Pruebas unitarias** — Para lógica crítica o reglas de negocio
- **Validación funcional** — Para verificar que cumple lo que se pidió
