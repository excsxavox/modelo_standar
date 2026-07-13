# Diseño Backend

**Proyecto:** [nombre]
**Módulo / Servicio:** [nombre]
**Historia relacionada:** US-[número]
**Fecha:** [fecha]

---

## Stack backend

| Elemento | Tecnología | Versión |
|----------|-----------|---------|
| Lenguaje | [Node.js / Python / C# / Java / otro] | [versión] |
| Framework | [Express / FastAPI / .NET / Spring / otro] | [versión] |
| ORM / Query builder | [Prisma / TypeORM / SQLAlchemy / otro] | [versión] |
| Autenticación | [JWT / OAuth2 / Sessions] | [versión] |
| Validación | [Zod / Joi / Pydantic / otro] | [versión] |
| Testing | [Jest / Pytest / xUnit / otro] | [versión] |

---

## Estructura de carpetas del módulo

```
src/
  [modulo]/
    [modulo].controller.ts    ← rutas y manejo de request/response
    [modulo].service.ts       ← lógica de negocio
    [modulo].repository.ts    ← acceso a datos
    [modulo].dto.ts           ← validación y tipado de entrada/salida
    [modulo].test.ts          ← pruebas unitarias
  shared/
    middleware/               ← auth, logging, manejo de errores
    utils/
    types/
```

---

## Endpoints del módulo

| Método | Ruta | Descripción | Auth | Request Body | Response |
|--------|------|-------------|------|-------------|----------|
| GET | /api/[recurso] | Listar todos | [ ] | — | `200 { data: [...] }` |
| GET | /api/[recurso]/:id | Obtener uno | [ ] | — | `200 { ...campos }` |
| POST | /api/[recurso] | Crear | [ ] | `{ campos }` | `201 { id, ...campos }` |
| PUT | /api/[recurso]/:id | Actualizar | [ ] | `{ campos }` | `200 { ...campos }` |
| DELETE | /api/[recurso]/:id | Eliminar | [ ] | — | `204` |

---

## Modelo de datos

```
Entidad: [NombreEntidad]
─────────────────────────
id          UUID / INT    PK
[campo]     [tipo]        [restricciones]
[campo]     [tipo]        NOT NULL
created_at  TIMESTAMP     DEFAULT NOW()
updated_at  TIMESTAMP
```

Relaciones:
- [NombreEntidad] tiene muchos [OtraEntidad]
- [NombreEntidad] pertenece a [OtraEntidad]

---

## Reglas de negocio

- [condición que el sistema debe validar]
- [qué ocurre si se viola la regla]

---

## Manejo de errores

| Código | Escenario | Mensaje |
|--------|-----------|---------|
| 400 | Datos inválidos en el body | `"Campo X es requerido"` |
| 401 | Token inválido o expirado | `"No autorizado"` |
| 403 | Sin permisos suficientes | `"Acceso denegado"` |
| 404 | Recurso no encontrado | `"[Recurso] no encontrado"` |
| 500 | Error interno | `"Error inesperado, intenta más tarde"` |

---

## Notas de seguridad y rendimiento
- [validaciones de entrada, sanitización, índices en BD, paginación]
