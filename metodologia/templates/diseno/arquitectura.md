# Arquitectura del sistema

**Proyecto:** [nombre]
**Fecha:** [fecha]
**Versión:** [v1.0]

---

## Tipo de arquitectura
- [ ] Monolítica
- [ ] Microservicios
- [ ] Serverless
- [ ] Híbrida
- [ ] Otra: [describir]

---

## Diagrama de componentes
```
[Diagrama en texto o referencia a archivo .mmd / imagen]

Ejemplo:
[Cliente Web] → [API Gateway] → [Servicio Auth]
                              → [Servicio Productos]
                              → [Servicio Pedidos]
                                      ↓
                              [Base de datos]
```

---

## Capas del sistema

| Capa | Responsabilidad | Tecnología |
|------|----------------|------------|
| Presentación | UI, interacción con el usuario | [framework frontend] |
| Aplicación | Lógica de negocio, casos de uso | [framework backend] |
| Datos | Persistencia, consultas | [base de datos] |
| Infraestructura | Hosting, CI/CD, servicios externos | [cloud / herramientas] |

---

## Comunicación entre capas

- **Frontend → Backend:** [REST / GraphQL / WebSocket]
- **Backend → BD:** [ORM / queries directas]
- **Servicios externos:** [APIs de terceros, nombre y propósito]

---

## Decisiones arquitectónicas clave

| Decisión | Alternativas consideradas | Razón de la elección |
|----------|--------------------------|----------------------|
| [ej. usar JWT] | [sessions, OAuth] | [stateless, escalable] |

---

## Restricciones y consideraciones
- [rendimiento esperado, límites de escala, seguridad, compliance]
