# Patrón Decorator

## Descripción general

El Decorator es un patrón de diseño estructural que permite añadir funcionalidades a un objeto de forma dinámica, envolviéndolo en capas sucesivas sin modificar su código original ni recurrir a una jerarquía de herencia extensa.

En Flutter, este principio está presente de forma nativa: envolver un `Text` en un `Padding`, y ese `Padding` en un `Center`, es exactamente la lógica del Decorator aplicada al árbol de widgets.

---

## Problema

Supón que tienes un café base y necesitas modelar todas sus combinaciones posibles con ingredientes adicionales.

**Enfoque incorrecto (explosión de subclases):**

```dart
class CafeConLeche extends Cafe { ... }
class CafeConAzucar extends Cafe { ... }
class CafeConLecheYAzucar extends Cafe { ... }
class CafeConCanela extends Cafe { ... }
```

Cada nueva combinación exige una clase adicional. El sistema se vuelve inmantenible.

**Enfoque correcto usando Decorator:**

```dart
Coffee myCoffee = SimpleCoffee();
myCoffee = MilkDecorator(myCoffee);
myCoffee = SugarDecorator(myCoffee);
```

Cada capa añade responsabilidad al objeto anterior sin alterar su interfaz.

---

## Estructura

| Componente | Rol |
|---|---|
| Component | Interfaz común para objetos base y decoradores (`Coffee`) |
| Concrete Component | Implementación base sin extras (`SimpleCoffee`) |
| Decorator | Clase abstracta que envuelve un componente y delega a él |
| Concrete Decorator | Añade funcionalidad específica (`MilkDecorator`, `SugarDecorator`) |

---

## Implementación en Dart

**`component/coffee.dart`**

```dart
abstract class Coffee {
  String getDescription();
  double getCost();
}
```

**`concrete_component/simple_coffee.dart`**

```dart
import '../component/coffee.dart';

class SimpleCoffee implements Coffee {
  @override
  String getDescription() => "Café negro";

  @override
  double getCost() => 50.0;
}
```

**`decorator/coffee_decorator.dart`**

```dart
import '../component/coffee.dart';

abstract class CoffeeDecorator implements Coffee {
  final Coffee _decoratedCoffee;

  CoffeeDecorator(this._decoratedCoffee);

  @override
  String getDescription() => _decoratedCoffee.getDescription();

  @override
  double getCost() => _decoratedCoffee.getCost();
}
```

**`decorator/milk_decorator.dart`**

```dart
import 'coffee_decorator.dart';

class MilkDecorator extends CoffeeDecorator {
  MilkDecorator(super.coffee);

  @override
  String getDescription() => "${super.getDescription()}, con leche";

  @override
  double getCost() => super.getCost() + 15.0;
}
```

**`decorator/sugar_decorator.dart`**

```dart
import 'coffee_decorator.dart';

class SugarDecorator extends CoffeeDecorator {
  SugarDecorator(super.coffee);

  @override
  String getDescription() => "${super.getDescription()}, con azúcar";

  @override
  double getCost() => super.getCost() + 5.0;
}
```

**`main.dart`**

```dart
import 'concrete_component/simple_coffee.dart';
import 'decorator/milk_decorator.dart';
import 'decorator/sugar_decorator.dart';

void main() {
  Coffee myCoffee = SimpleCoffee();
  print("${myCoffee.getDescription()} -> \$${myCoffee.getCost()}");

  myCoffee = MilkDecorator(myCoffee);
  print("${myCoffee.getDescription()} -> \$${myCoffee.getCost()}");

  myCoffee = SugarDecorator(myCoffee);
  print("${myCoffee.getDescription()} -> \$${myCoffee.getCost()}");
}
```

**Salida esperada:**

```text
Café negro -> $50.0
Café negro, con leche -> $65.0
Café negro, con leche, con azúcar -> $70.0
```

---

## Ventajas y desventajas

**Ventajas**
- Añade responsabilidades a objetos individuales en tiempo de ejecución sin afectar a otros
- Evita la explosión de subclases derivada de modelar todas las combinaciones posibles
- Cada decorador tiene una responsabilidad única y acotada
- Sigue el Principio Abierto/Cerrado y el Principio de Responsabilidad Única

**Desventajas**
- Una cadena larga de decoradores puede dificultar la depuración
- El orden en que se aplican los decoradores afecta el resultado y debe gestionarse con cuidado
- Puede resultar excesivo para casos donde bastara con una subclase simple

---

## Diferencia con el patrón Bridge

| Decorator | Bridge |
|---|---|
| Añade responsabilidades a un objeto existente | Separa abstracción e implementación desde el diseño |
| No modifica la interfaz original | Define dos jerarquías independientes desde el inicio |
| Se aplica en tiempo de ejecución | La separación es estructural |

---

## Cuándo utilizarlo

Aplica el patrón Decorator cuando:

- Se necesita extender el comportamiento de objetos de forma flexible y combinable
- El uso de herencia generaría un número inmanejable de subclases
- Las funcionalidades adicionales deben poder activarse o desactivarse en tiempo de ejecución

---

## Aplicaciones en Flutter

- Composición del árbol de widgets (`Padding`, `Center`, `Expanded`)
- Añadir comportamientos a streams o repositorios (logging, caché, reintentos)
- Extensión de servicios sin modificar su implementación base

---

## Estructura del proyecto

```
decorator/
│
├── component/
│   └── coffee.dart
│
├── concrete_component/
│   └── simple_coffee.dart
│
├── decorator/
│   ├── coffee_decorator.dart
│   ├── milk_decorator.dart
│   └── sugar_decorator.dart
│
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart structural/decorator/main.dart
```