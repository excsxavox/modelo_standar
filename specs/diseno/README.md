# Diseño del sistema — fuente de verdad

Este directorio refleja el diseño actual del sistema (lo que ya existe y funciona).
Se actualiza al cerrar cada cambio desde `trabajo/[nombre-cambio]/diseno/`.

## Archivos
- `arquitectura.md` — arquitectura actual del sistema
- `frontend.md` — estado actual del frontend (componentes, stack, estructura)
- `backend.md` — estado actual del backend (endpoints, modelos, servicios)

## Regla de sincronización
Al cerrar un cambio, el agente aplica SOLO los deltas relevantes.
No se reescribe el archivo completo — se actualiza la sección afectada.
