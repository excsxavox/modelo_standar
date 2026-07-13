# Casos de prueba unitaria

**Módulo / Función:** [nombre]
**Historia relacionada:** US-[número]
**Fecha:** [fecha]

---

## Caso 1 — Happy path: [descripción breve]

```
// Arrange
const [input] = [valor válido];
const [dependencia] = mock([comportamiento esperado]);

// Act
const resultado = [funcionBajoTest]([input]);

// Assert
expect(resultado).toBe([valorEsperado]);
```

**Resultado esperado:** [descripción]
**Estado:** [ ] Pendiente  [ ] Aprobado  [ ] Fallido

---

## Caso 2 — Caso borde: [descripción breve]

```
// Arrange
const [input] = [valor límite o nulo];

// Act
const resultado = [funcionBajoTest]([input]);

// Assert
expect(resultado).toBe([valorEsperadoEnBorde]);
```

**Resultado esperado:** [descripción]
**Estado:** [ ] Pendiente  [ ] Aprobado  [ ] Fallido

---

## Caso 3 — Error esperado: [descripción breve]

```
// Arrange
const [input] = [valor inválido];

// Act & Assert
expect(() => [funcionBajoTest]([input])).toThrow('[mensaje de error esperado]');
```

**Resultado esperado:** [descripción]
**Estado:** [ ] Pendiente  [ ] Aprobado  [ ] Fallido

---

## Resumen de cobertura

| Función / Método | Happy Path | Caso Borde | Error | Cobertura |
|-----------------|-----------|-----------|-------|-----------|
| [nombreFuncion] | [ ] | [ ] | [ ] | [x]% |
