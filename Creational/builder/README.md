# Patrón Builder

## Descripción general

El Builder es un patrón de diseño creacional que permite construir objetos complejos paso a paso, separando el proceso de construcción de la representación final del objeto.

En lugar de un constructor con múltiples parámetros, se encadenan llamadas a métodos específicos que configuran cada parte del objeto de forma explícita y legible.

---

## Problema

Considera una clase `House` con múltiples atributos opcionales: ventanas, puertas, garaje, piscina, color de paredes, entre otros.

**Enfoque incorrecto (constructor telescópico):**

```dart
final house = House(12, 4, true, true, "Beige");
```

Este enfoque es frágil, difícil de leer y propenso a errores cuando el orden de los parámetros cambia.

**Enfoque correcto usando Builder:**

```dart
builder.setWindows(12);
builder.setDoors(4);
builder.setWallColor("Beige");
builder.addGarage();
builder.addPool();

final house = builder.getResult();
```

Cada paso es explícito, legible y la configuración puede variar sin modificar la interfaz.

---

## Estructura

| Componente | Rol |
|---|---|
| Product | Objeto complejo a construir (`House`) |
| Builder | Interfaz que define los pasos de construcción |
| Concrete Builder | Implementa los pasos y ensambla el producto |
| Director (opcional) | Encapsula secuencias de construcción predefinidas |

---

## Implementación en Dart

**`product/house.dart`**

```dart
class House {
  int windows = 0;
  int doors = 0;
  bool hasGarage = false;
  bool hasSwimmingPool = false;
  String wallColor = "White";

  void showDetails() {
    print("Ventanas: $windows | Puertas: $doors");
    print("Color de paredes: $wallColor");
    print("Garaje: $hasGarage | Piscina: $hasSwimmingPool");
  }
}
```

**`builder/house_builder.dart`**

```dart
import '../product/house.dart';

abstract class HouseBuilder {
  void reset();
  void setWindows(int count);
  void setDoors(int count);
  void setWallColor(String color);
  void addGarage();
  void addPool();
  House getResult();
}
```

**`builder/concrete_house_builder.dart`**

```dart
import '../product/house.dart';
import 'house_builder.dart';

class ConcreteHouseBuilder implements HouseBuilder {
  late House _house;

  ConcreteHouseBuilder() {
    reset();
  }

  @override
  void reset() => _house = House();

  @override
  void setWindows(int count) => _house.windows = count;

  @override
  void setDoors(int count) => _house.doors = count;

  @override
  void setWallColor(String color) => _house.wallColor = color;

  @override
  void addGarage() => _house.hasGarage = true;

  @override
  void addPool() => _house.hasSwimmingPool = true;

  @override
  House getResult() {
    final product = _house;
    reset();
    return product;
  }
}
```

**`main.dart`**

```dart
import 'builder/concrete_house_builder.dart';
import 'product/house.dart';

void main() {
  final builder = ConcreteHouseBuilder();

  builder.setWindows(12);
  builder.setDoors(4);
  builder.setWallColor("Beige");
  builder.addGarage();
  builder.addPool();
  final mansion = builder.getResult();
  mansion.showDetails();

  builder.setWindows(2);
  builder.setDoors(1);
  builder.setWallColor("Gris");
  final simpleHouse = builder.getResult();
  simpleHouse.showDetails();
}
```

**Salida esperada:**

```text
Ventanas: 12 | Puertas: 4
Color de paredes: Beige
Garaje: true | Piscina: true

Ventanas: 2 | Puertas: 1
Color de paredes: Gris
Garaje: false | Piscina: false
```

---

## El Director (variante avanzada)

El Director es una clase opcional que encapsula secuencias de construcción predefinidas. En lugar de que el cliente configure el builder paso a paso, el Director expone métodos con configuraciones reutilizables.

```dart
class HouseDirector {
  final HouseBuilder _builder;

  HouseDirector(this._builder);

  House buildMansion() {
    _builder.setWindows(12);
    _builder.setDoors(4);
    _builder.setWallColor("Beige");
    _builder.addGarage();
    _builder.addPool();
    return _builder.getResult();
  }

  House buildSimpleHouse() {
    _builder.setWindows(2);
    _builder.setDoors(1);
    _builder.setWallColor("Blanco");
    return _builder.getResult();
  }
}
```

Con el Director, el cliente delega completamente la lógica de construcción:

```dart
final director = HouseDirector(ConcreteHouseBuilder());
final mansion = director.buildMansion();
```

---

## Ventajas y desventajas

**Ventajas**
- Permite construir objetos complejos paso a paso con total control sobre cada atributo
- El mismo proceso de construcción puede producir representaciones distintas
- Aísla el código de construcción de la lógica de negocio del cliente
- Facilita la reutilización de secuencias de construcción mediante el Director

**Desventajas**
- Incrementa el número de clases necesarias
- Puede ser excesivo para objetos con pocos atributos o poca variabilidad

---

## Cuándo utilizarlo

Aplica el patrón Builder cuando:

- El objeto a construir requiere muchos parámetros, especialmente opcionales
- Se necesitan distintas representaciones del mismo objeto
- La construcción implica pasos ordenados o con lógica compleja

---

## Aplicaciones en Flutter

- Construcción de objetos de configuración para servicios (HTTP clients, temas, rutas)
- Generación de formularios o widgets complejos con múltiples variantes
- Ensamblado de peticiones API con parámetros opcionales

---

## Estructura del proyecto

```
builder/
│
├── builder/
│   ├── house_builder.dart
│   └── concrete_house_builder.dart
│
├── product/
│   └── house.dart
│
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart run creational/builder/main.dart
```