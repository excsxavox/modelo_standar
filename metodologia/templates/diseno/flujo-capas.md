# Flujo de capas del cambio

**Módulo / Cambio:** [nombre]
**Historia relacionada:** US-[número]
**Fecha:** [fecha]
**Modo:** [ ] Código existente (top-down)  [ ] Código nuevo (inside-out)

---

## Ramificación de capas

```
ENTRADA: [descripción del input — HTTP request, evento, job, etc.]
  │
  ├── Route / Endpoint
  │     Método:   [GET / POST / PUT / DELETE]
  │     Ruta:     [/api/v1/recurso]
  │     Auth:     [si / no / rol requerido]
  │     Estado:   [ ] Nuevo  [ ] Modifica  [ ] Sin cambio
  │
  ├── Controller
  │     Archivo:  [ruta/al/controller.ts]
  │     Valida:   [qué campos valida del request]
  │     Llama a:  [ServiceNombre.metodo()]
  │     Estado:   [ ] Nuevo  [ ] Modifica  [ ] Sin cambio
  │
  ├── Service
  │     Archivo:  [ruta/al/service.ts]
  │     Lógica:   [reglas de negocio que aplica]
  │     Llama a:  [RepositoryNombre.metodo()]
  │     Estado:   [ ] Nuevo  [ ] Modifica  [ ] Sin cambio
  │
  ├── Repository
  │     Archivo:  [ruta/al/repository.ts]
  │     Query:    [SELECT/INSERT/UPDATE/DELETE — descripción]
  │     Tabla:    [nombre_tabla]
  │     Estado:   [ ] Nuevo  [ ] Modifica  [ ] Sin cambio
  │
  ├── Model / Entity
  │     Archivo:  [ruta/al/model.ts]
  │     Campos nuevos o modificados:
  │       - [campo]: [tipo] [restricciones]
  │     Estado:   [ ] Nuevo  [ ] Modifica  [ ] Sin cambio
  │
  └── Base de datos / API externa
        Cambio:   [nueva tabla / migración / nueva columna / API externa]
        Estado:   [ ] Nuevo  [ ] Modifica  [ ] Sin cambio

SALIDA: [descripción del output — HTTP response, evento emitido, etc.]
  Código:   [200 / 201 / 204 / 400 / etc.]
  Formato:  [{ campo: tipo, ... }]
```

---

## Orden de implementación

### Si es código nuevo (inside-out):
- [ ] 1. Model / Entity
- [ ] 2. Migración / Esquema BD
- [ ] 3. Repository
- [ ] 4. Service
- [ ] 5. Controller
- [ ] 6. Route / Endpoint
- [ ] 7. Validar Response

### Si modifica código existente (top-down):
- [ ] 1. Leer Route → entender contrato actual
- [ ] 2. Leer Controller → entender validaciones actuales
- [ ] 3. Leer Service → entender lógica actual
- [ ] 4. Leer Repository → entender queries actuales
- [ ] 5. Leer Model → entender estructura actual
- [ ] 6. Aplicar cambios en la capa correspondiente
- [ ] 7. Actualizar capas superiores si el contrato cambia

---

## Capas afectadas por este cambio

| Capa | Archivo | Tipo de cambio |
|------|---------|---------------|
| Route | [archivo] | Nuevo / Modifica |
| Controller | [archivo] | Nuevo / Modifica |
| Service | [archivo] | Nuevo / Modifica |
| Repository | [archivo] | Nuevo / Modifica |
| Model | [archivo] | Nuevo / Modifica |
| BD | [tabla/migración] | Nuevo / Modifica |

---

## Diagramas .mmd generados

Por cada controlador o endpoint de este cambio, el agente genera un `.mmd`
usando `metodologia/templates/diseno/diagramas/diagrama-capas.mmd`.

| Endpoint | Archivo .mmd | Ubicación |
|----------|-------------|-----------|
| [METODO /ruta] | [metodo-recurso.mmd] | `trabajo/[cambio]/diseno/diagramas/` |

Al cerrar el cambio → mover a `specs/diseno/diagramas/`.
