# Metodología Personal de Desarrollo — Edison

Repositorio independiente que contiene las reglas y metodología para trabajar con el agente de Cursor en cualquier proyecto.

## Estructura

```
.cursor/
  rules/
    mi-metodologia.mdc   ← único archivo de reglas (alwaysApply: true)
README.md
```

## Cómo funciona

El archivo `mi-metodologia.mdc` tiene 6 secciones:

| Sección | Contenido | ¿Cambia? |
|---------|-----------|----------|
| 1. Perfil personal | Nombre, idioma, estilo de respuesta | No |
| 2. Fases de desarrollo | Fases opcionales disponibles | No |
| 3. Historias de usuario | Formato y criterios de aceptación | No |
| 4. Calidad y limpieza | Estándares de código | No |
| 5. Pruebas y validación | Estructura AAA, validación funcional | No |
| 6. Proyecto actual | Config del proyecto activo | **Solo esta** |

## Uso por proyecto

### Nuevo proyecto

```bash
git checkout main
git checkout -b proyecto/nombre-del-proyecto
```

Luego edita solo la Sección 6 del archivo `.cursor/rules/mi-metodologia.mdc`:

```markdown
# 6. Proyecto actual
- Nombre: Mi App
- Stack: React, Node.js, PostgreSQL
- Descripción: Plataforma de gestión de tareas
- Entornos: dev / prod
- Notas: API REST en /api/v1, autenticación con JWT
```

### Listar proyectos activos

```bash
git branch
```

### Actualizar la metodología base

```bash
git checkout main
# editar mi-metodologia.mdc (secciones 1-5 únicamente)
git add .
git commit -m "mejora: [descripción del cambio]"

# Aplicar la mejora a un proyecto existente
git checkout proyecto/nombre-del-proyecto
git merge main
```

## Ramas disponibles

- `main` — Base genérica de la metodología
- `proyecto/*` — Una rama por cada proyecto activo

## Fases disponibles

Al iniciar un cambio con el agente, este preguntará qué fases activar:

- **Historias de usuario** — Para requerimientos nuevos o poco claros
- **Diseño** — Para cambios con impacto en arquitectura
- **Limpieza de código** — Para resolver deuda técnica antes de implementar
- **Calidad de código** — Para revisión de estándares
- **Pruebas unitarias** — Para lógica crítica o reglas de negocio
- **Validación funcional** — Para verificar que cumple lo que se pidió
