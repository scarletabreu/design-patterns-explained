# Patrón Visitor

## Descripción general

El Visitor es un patrón de diseño de comportamiento que permite añadir nuevas operaciones a una estructura de objetos existente sin modificar las clases de esos objetos.

La lógica de cada operación se extrae de los elementos y se centraliza en una clase visitante dedicada, manteniendo los datos separados de los algoritmos que operan sobre ellos.

---

## Problema

Considera un sistema con distintos tipos de monstruos: `Dragon`, `Goblin`. Si se necesita añadir operaciones como "exportar a JSON" o "calcular daño por fuego", la solución directa sería modificar cada clase.

**Enfoque incorrecto (modificar clases existentes):**

```dart
class Dragon {
  void exportToJson() { ... }
  void calculateFireDamage() { ... }
  // crece indefinidamente con cada nueva operación
}
```

**Enfoque correcto usando Visitor:**

```dart
monster.accept(StatsVisitor());
monster.accept(ExportVisitor());
```

Cada nueva operación se implementa en un visitante independiente, sin tocar las clases de los monstruos.

---

## Estructura

| Componente | Rol |
|---|---|
| Element | Interfaz base con el método `accept` (`Monster`) |
| Concrete Element | Implementación específica que acepta visitantes (`Dragon`, `Goblin`) |
| Visitor | Interfaz con un método por cada tipo de elemento (`MonsterVisitor`) |
| Concrete Visitor | Implementa la operación concreta para cada tipo (`StatsVisitor`) |

---

## Implementación en Dart

**`element/monster.dart`**

```dart
import '../visitor/monster_visitor.dart';

abstract class Monster {
  String name;
  Monster(this.name);

  void accept(MonsterVisitor visitor);
}
```

**`element/dragon.dart`**

```dart
import '../visitor/monster_visitor.dart';
import 'monster.dart';

class Dragon extends Monster {
  int firePower = 100;

  Dragon(String name) : super(name);

  @override
  void accept(MonsterVisitor visitor) => visitor.visitDragon(this);
}
```

**`element/goblin.dart`**

```dart
import '../visitor/monster_visitor.dart';
import 'monster.dart';

class Goblin extends Monster {
  int stealth = 50;

  Goblin(String name) : super(name);

  @override
  void accept(MonsterVisitor visitor) => visitor.visitGoblin(this);
}
```

**`visitor/monster_visitor.dart`**

```dart
import '../element/dragon.dart';
import '../element/goblin.dart';

abstract class MonsterVisitor {
  void visitDragon(Dragon dragon);
  void visitGoblin(Goblin goblin);
}
```

**`visitor/stats_visitor.dart`**

```dart
import '../element/dragon.dart';
import '../element/goblin.dart';
import 'monster_visitor.dart';

class StatsVisitor implements MonsterVisitor {
  @override
  void visitDragon(Dragon dragon) {
    print("Dragon ${dragon.name} — poder de fuego: ${dragon.firePower}");
  }

  @override
  void visitGoblin(Goblin goblin) {
    print("Goblin ${goblin.name} — sigilo: ${goblin.stealth}");
  }
}
```

**`main.dart`**

```dart
import 'element/dragon.dart';
import 'element/goblin.dart';
import 'element/monster.dart';
import 'visitor/stats_visitor.dart';

void main() {
  final List<Monster> monsters = [
    Dragon("Viserion"),
    Goblin("Dobby"),
    Dragon("Drogon"),
  ];

  final visitor = StatsVisitor();

  for (var monster in monsters) {
    monster.accept(visitor);
  }
}
```

**Salida esperada:**

```text
Dragon Viserion — poder de fuego: 100
Goblin Dobby — sigilo: 50
Dragon Drogon — poder de fuego: 100
```

---

## Double Dispatch

El mecanismo central del patrón es el **double dispatch**: el cliente no necesita conocer el tipo concreto del elemento. Cuando llama a `accept`, el elemento conoce su propio tipo y redirige la llamada al método correcto del visitante (`visitDragon` o `visitGoblin`). La decisión se toma en dos pasos: primero por el tipo del elemento, luego por el tipo del visitante.

---

## Ventajas y desventajas

**Ventajas**
- Permite añadir operaciones nuevas sin modificar las clases de los elementos
- Centraliza la lógica de cada operación en una sola clase
- Separa claramente los datos de los algoritmos que los procesan
- Sigue el Principio Abierto/Cerrado y el Principio de Responsabilidad Única

**Desventajas**
- Añadir un nuevo tipo de elemento requiere actualizar la interfaz del visitante y todas sus implementaciones
- No es adecuado si la jerarquía de elementos cambia con frecuencia

---

## Cuándo utilizarlo

Aplica el patrón Visitor cuando:

- La estructura de clases de los elementos es estable pero las operaciones sobre ellos cambian o crecen con frecuencia
- Se necesita ejecutar operaciones distintas e independientes sobre una misma estructura de objetos
- Se quiere evitar contaminar las clases de dominio con lógica de presentación, persistencia u otras responsabilidades

---

## Estructura del proyecto

```
visitor/
│
├── element/
│   ├── monster.dart
│   ├── dragon.dart
│   └── goblin.dart
│
├── visitor/
│   ├── monster_visitor.dart
│   └── stats_visitor.dart
│
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart behavioral/visitor/main.dart
```