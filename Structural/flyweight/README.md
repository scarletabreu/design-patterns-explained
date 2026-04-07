# Patrón Flyweight

## Descripción general

El Flyweight es un patrón de diseño estructural que permite **reducir el
uso de memoria compartiendo objetos comunes** en lugar de crear
múltiples instancias idénticas.

Separa el estado en:

-   **Intrínseco (compartido)**
-   **Extrínseco (externo)**

------------------------------------------------------------------------

## Problema

Supón que necesitas representar miles de árboles en un juego:

-   Cada árbol tiene: tipo, textura, color
-   Cada instancia tiene: posición (x, y)

Esto genera alto consumo de memoria.

**Enfoque incorrecto:**

``` dart
class Tree {
  String type;
  String texture;
  String color;
  int x;
  int y;
}
```

**Enfoque correcto usando Flyweight:**

``` dart
final treeType = factory.getTreeType("Pino", "verde", "rugosa");
treeType.draw(10, 20);
```

------------------------------------------------------------------------

## Estructura

  Componente           Rol
  -------------------- ---------------------------
  Flyweight            Interfaz (`TreeType`)
  Concrete Flyweight   Implementación compartida
  Factory              Reutiliza instancias
  Context              Estado externo

------------------------------------------------------------------------

## Implementación en Dart

**tree_type.dart**

``` dart
abstract class TreeType {
  void draw(int x, int y);
}
```

**concrete_tree_type.dart**

``` dart
import 'tree_type.dart';

class ConcreteTreeType implements TreeType {
  final String name;
  final String color;
  final String texture;

  ConcreteTreeType(this.name, this.color, this.texture);

  @override
  void draw(int x, int y) {
    print("Dibujando $name en ($x, $y) con color $color y textura $texture");
  }
}
```

**tree_factory.dart**

``` dart
import 'concrete_tree_type.dart';

class TreeFactory {
  static final Map<String, ConcreteTreeType> _treeTypes = {};

  static ConcreteTreeType getTreeType(String name, String color, String texture) {
    final key = "$name-$color-$texture";

    if (!_treeTypes.containsKey(key)) {
      _treeTypes[key] = ConcreteTreeType(name, color, texture);
    }

    return _treeTypes[key]!;
  }
}
```

**tree.dart**

``` dart
import '../flyweight/tree_type.dart';

class Tree {
  final int x;
  final int y;
  final TreeType type;

  Tree(this.x, this.y, this.type);

  void draw() {
    type.draw(x, y);
  }
}
```

**main.dart**

``` dart
import 'flyweight/tree_factory.dart';
import 'context/tree.dart';

void main() {
  final trees = <Tree>[];

  final pineType = TreeFactory.getTreeType("Pino", "Verde", "Rugosa");
  final oakType = TreeFactory.getTreeType("Roble", "Oscuro", "Lisa");

  trees.add(Tree(10, 20, pineType));
  trees.add(Tree(30, 40, pineType));
  trees.add(Tree(50, 60, oakType));

  for (var tree in trees) {
    tree.draw();
  }
}
```

------------------------------------------------------------------------

## Ventajas y desventajas

**Ventajas** - Reduce memoria - Mejora rendimiento

**Desventajas** - Mayor complejidad

------------------------------------------------------------------------

## Cuándo usarlo

-   Muchos objetos similares
-   Problemas de memoria

------------------------------------------------------------------------

## Estructura del proyecto

    flyweight/
    ├── flyweight/
    ├── context/
    ├── main.dart

------------------------------------------------------------------------

## Ejecución

``` bash
dart structural/flyweight/main.dart
```
