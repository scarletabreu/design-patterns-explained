# Patrón Interpreter (Intérprete)

## Descripción general

El Interpreter es un patrón de diseño de comportamiento que define una representación gramatical para un lenguaje y proporciona un intérprete para procesar esa gramática. Se utiliza para interpretar sentencias de un lenguaje simple, donde cada regla gramatical se mapea a una clase.

---

## Problema

Considera una aplicación que debe evaluar expresiones de filtrado escritas por el usuario, como `"activo AND (admin OR soporte)"`. Sin un patrón estructurado, el parseo y la evaluación quedan mezclados en bloques de condicionales difíciles de mantener y extender.

**Enfoque incorrecto (evaluación ad hoc):**

```dart
// Lógica dispersa con condicionales anidados
if (expr.contains("AND")) {
  final parts = expr.split("AND");
  // evaluar partes manualmente...
}
```

Este enfoque no es extensible: agregar un operador nuevo obliga a modificar el parseo completo.

**Enfoque correcto usando Interpreter:**

```dart
final context = {"activo": true, "admin": false, "soporte": true};

final expression = AndExpression(
  TerminalExpression("activo"),
  OrExpression(
    TerminalExpression("admin"),
    TerminalExpression("soporte"),
  ),
);

print(expression.interpret(context)); // true
```

Cada regla es un objeto independiente y la gramática se construye componiendo expresiones.

---

## Estructura

| Componente | Rol |
|---|---|
| AbstractExpression | Interfaz con el método `interpret(context)` |
| TerminalExpression | Expresión hoja; evalúa un símbolo directamente sobre el contexto |
| NonTerminalExpression | Expresión compuesta; combina otras expresiones (AND, OR, NOT) |
| Context | Mapa con los valores o variables que el intérprete necesita para evaluar |
| Client | Construye el árbol de expresiones y dispara la interpretación |

---

## Implementación en Dart

**`expression/expression.dart`**

```dart
abstract class Expression {
  bool interpret(Map<String, bool> context);
}
```

**`expression/terminal_expression.dart`**

```dart
import 'expression.dart';

class TerminalExpression implements Expression {
  final String _variable;

  TerminalExpression(this._variable);

  @override
  bool interpret(Map<String, bool> context) {
    return context[_variable] ?? false;
  }
}
```

**`expression/and_expression.dart`**

```dart
import 'expression.dart';

class AndExpression implements Expression {
  final Expression _left;
  final Expression _right;

  AndExpression(this._left, this._right);

  @override
  bool interpret(Map<String, bool> context) {
    return _left.interpret(context) && _right.interpret(context);
  }
}
```

**`expression/or_expression.dart`**

```dart
import 'expression.dart';

class OrExpression implements Expression {
  final Expression _left;
  final Expression _right;

  OrExpression(this._left, this._right);

  @override
  bool interpret(Map<String, bool> context) {
    return _left.interpret(context) || _right.interpret(context);
  }
}
```

**`expression/not_expression.dart`**

```dart
import 'expression.dart';

class NotExpression implements Expression {
  final Expression _operand;

  NotExpression(this._operand);

  @override
  bool interpret(Map<String, bool> context) {
    return !_operand.interpret(context);
  }
}
```

**`main.dart`**

```dart
import 'expression/terminal_expression.dart';
import 'expression/and_expression.dart';
import 'expression/or_expression.dart';
import 'expression/not_expression.dart';

void main() {
  final context = {
    "activo": true,
    "admin": false,
    "soporte": true,
  };

  // Expresión: activo AND (admin OR soporte)
  final expr1 = AndExpression(
    TerminalExpression("activo"),
    OrExpression(
      TerminalExpression("admin"),
      TerminalExpression("soporte"),
    ),
  );

  // Expresión: NOT admin
  final expr2 = NotExpression(TerminalExpression("admin"));

  // Expresión: activo AND NOT admin
  final expr3 = AndExpression(
    TerminalExpression("activo"),
    NotExpression(TerminalExpression("admin")),
  );

  print("activo AND (admin OR soporte): ${expr1.interpret(context)}");
  print("NOT admin: ${expr2.interpret(context)}");
  print("activo AND NOT admin: ${expr3.interpret(context)}");
}
```

**Salida esperada:**

```text
activo AND (admin OR soporte): true
NOT admin: true
activo AND NOT admin: true
```

---

## Extensión: soporte para nuevos operadores

El árbol de expresiones es fácilmente extensible. Para agregar un operador XOR basta con crear una nueva clase sin modificar las existentes:

```dart
class XorExpression implements Expression {
  final Expression _left;
  final Expression _right;

  XorExpression(this._left, this._right);

  @override
  bool interpret(Map<String, bool> context) {
    final l = _left.interpret(context);
    final r = _right.interpret(context);
    return (l || r) && !(l && r);
  }
}
```

Con esto, el cliente puede componer expresiones XOR sin alterar ninguna clase existente:

```dart
final xorExpr = XorExpression(
  TerminalExpression("admin"),
  TerminalExpression("soporte"),
);
print("admin XOR soporte: ${xorExpr.interpret(context)}"); // true
```

---

## Ventajas y desventajas

**Ventajas**
- Facilita la extensión de la gramática agregando nuevas clases de expresión
- Cada regla gramatical queda encapsulada en su propia clase, lo que mejora la cohesión
- El árbol de expresiones es fácil de inspeccionar, modificar y probar de forma unitaria
- Permite representar y evaluar lenguajes simples de forma declarativa

**Desventajas**
- Gramáticas complejas generan un gran número de clases difíciles de gestionar
- No es adecuado para lenguajes con gramáticas elaboradas; en esos casos se prefieren generadores de parsers
- El rendimiento puede verse afectado para árboles de expresión muy grandes

---

## Cuándo utilizarlo

Aplica el patrón Interpreter cuando:

- Se necesita interpretar sentencias de un lenguaje con gramática simple y bien definida
- Las reglas del lenguaje son estables y no cambian con frecuencia
- Se quiere representar expresiones lógicas, matemáticas o de configuración como árboles de objetos
- El número de reglas es reducido y manejable

---

## Aplicaciones en Flutter

- Evaluación de reglas de negocio o condiciones de visibilidad de widgets
- Filtrado dinámico de listas mediante expresiones definidas por el usuario
- Motor de permisos y roles basado en expresiones lógicas
- Parseo y evaluación de fórmulas simples en aplicaciones de hoja de cálculo o reportes

---

## Estructura del proyecto

```
interpreter/
│
├── expression/
│   ├── expression.dart
│   ├── terminal_expression.dart
│   ├── and_expression.dart
│   ├── or_expression.dart
│   └── not_expression.dart
│
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart run behavioral/interpreter/main.dart
```
