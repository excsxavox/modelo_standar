# AIBox Agents — Workspace del Proyecto

Este directorio es gestionado por AIBox Agents.

## Estructura

```
.aibox/          → Contexto interno de los agentes (specs, steerings, memoria)
documents/       → Documentación generada por las AIs (ADR, diseño, reportes)
shared/          → Documentación de entrada proporcionada por el usuario
sources/         → Repositorios git clonados del proyecto
```

## Notas

- La carpeta `.aibox/` no debe modificarse manualmente.
- Los documentos en `documents/` son output del sistema.
- Los archivos en `shared/` son input del usuario.
