# Diseño Frontend

**Proyecto:** [nombre]
**Módulo / Vista:** [nombre de la pantalla o módulo]
**Historia relacionada:** US-[número]
**Fecha:** [fecha]

---

## Stack frontend

| Elemento | Tecnología | Versión |
|----------|-----------|---------|
| Framework UI | [React / Vue / Angular / otro] | [versión] |
| Estilos | [Tailwind / SCSS / CSS Modules / otro] | [versión] |
| Estado global | [Redux / Zustand / Pinia / otro] | [versión] |
| Routing | [React Router / Vue Router / otro] | [versión] |
| Peticiones HTTP | [Axios / Fetch / TanStack Query] | [versión] |
| Testing | [Jest / Vitest / Testing Library] | [versión] |

---

## Estructura de carpetas del módulo

```
src/
  components/
    [NombreComponente]/
      index.tsx          ← componente principal
      [NombreComponente].test.tsx
      styles.module.css  ← estilos locales (si aplica)
  pages/
    [NombrePagina].tsx
  hooks/
    use[NombreHook].ts
  services/
    [nombre].service.ts  ← llamadas a la API
  types/
    [nombre].types.ts
```

---

## Componentes a crear / modificar

| Componente | Tipo | Descripción | Estado |
|-----------|------|-------------|--------|
| [nombre] | Nuevo / Modificar | [qué hace] | [ ] |

---

## Flujo de la pantalla

```
[Paso 1: el usuario llega a la vista]
  → [qué ve primero]
  → [acción principal disponible]
  → [resultado de la acción]
  → [estados: cargando / éxito / error]
```

---

## Estados de la UI

| Estado | Descripción | Comportamiento visual |
|--------|-------------|----------------------|
| Inicial | Vista recién cargada | [skeleton / spinner / contenido] |
| Cargando | Petición en curso | [loader, deshabilitar botones] |
| Éxito | Datos recibidos | [mostrar datos] |
| Error | Falla en la petición | [mensaje de error, reintentar] |
| Vacío | Sin datos | [empty state con mensaje] |

---

## Contrato con el backend (endpoints usados)

| Método | Endpoint | Request | Response |
|--------|----------|---------|----------|
| GET | /api/[recurso] | — | `{ data: [...] }` |
| POST | /api/[recurso] | `{ campo: valor }` | `{ id, ...campos }` |

---

## Notas de accesibilidad y UX
- [aria-labels, contraste, navegación por teclado, responsive]
