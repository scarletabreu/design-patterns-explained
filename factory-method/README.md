# Patrón Factory Method

## Descripción general

El Factory Method es un patrón de diseño creacional que define una interfaz para crear objetos, permitiendo que las subclases decidan qué clase instanciar.

En lugar de usar `new` directamente, la creación de objetos se delega a una fábrica, desacoplando al cliente de las implementaciones concretas.

---

## Problema

Considera un sistema que necesita instanciar distintos tipos de objetos según el contexto:

- `Dog`
- `Cat`

**Enfoque con alto acoplamiento (problemático):**

```dart
final animal = Dog(); // dependencia directa de una clase concreta
```

Esto hace que el código sea rígido y difícil de extender o probar.

**Enfoque desacoplado usando Factory Method:**

```dart
Animal animal = factory.createAnimal();
```

El cliente depende únicamente de la interfaz `Animal`, no de ninguna implementación específica.

---

## Estructura

| Componente | Rol |
|---|---|
| Producto | Interfaz común (`Animal`) |
| Producto concreto | Implementaciones específicas (`Dog`, `Cat`) |
| Creador | Fábrica abstracta que define el método de creación |
| Creador concreto | Decide qué objeto instanciar |

---

## Implementación en Dart

**1. Producto**

```dart
abstract class Animal {
  void speak();
}
```

**2. Productos concretos**

```dart
class Dog implements Animal {
  @override
  void speak() {
    print("Woof");
  }
}

class Cat implements Animal {
  @override
  void speak() {
    print("Meow");
  }
}
```

**3. Creador**

```dart
abstract class AnimalFactory {
  Animal createAnimal();
}
```

**4. Creadores concretos**

```dart
class DogFactory implements AnimalFactory {
  @override
  Animal createAnimal() => Dog();
}

class CatFactory implements AnimalFactory {
  @override
  Animal createAnimal() => Cat();
}
```

**5. Uso**

```dart
void main() {
  AnimalFactory factory = DogFactory();
  Animal animal = factory.createAnimal();
  animal.speak();
}
```

---

## Ventajas y desventajas

**Ventajas**
- Reduce el acoplamiento entre el código cliente y las clases concretas
- Simplifica la incorporación de nuevos tipos (`Bird`, `Fish`, etc.) sin modificar el código existente
- Sigue el Principio Abierto/Cerrado

**Desventajas**
- Incrementa el número de clases en el proyecto
- Puede introducir complejidad innecesaria en casos simples

---

## Variante simplificada: Simple Factory

Cuando no se requiere una jerarquía de clases completa, un método de fábrica estático puede ser suficiente:

```dart
enum AnimalType { dog, cat }

class SimpleAnimalFactory {
  static Animal createAnimal(AnimalType type) {
    switch (type) {
      case AnimalType.dog:
        return Dog();
      case AnimalType.cat:
        return Cat();
    }
  }
}
```
---

## Cuándo utilizarlo

Aplica el patrón Factory Method cuando:

- El tipo exacto de objeto a crear se determina en tiempo de ejecución
- Se desea desacoplar la creación de objetos de su uso
- El sistema debe estar abierto a extensión sin necesidad de modificar el código existente

---

## Aplicaciones en Flutter

- Instanciar distintos tipos de widgets según el estado de la aplicación
- Generar servicios específicos por entorno (desarrollo vs. producción)
- Gestionar múltiples implementaciones de clientes de API

---

## Estructura del proyecto

```
factory-method/
│
├── animal.dart
├── dog.dart
├── cat.dart
├── factory.dart
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart run main.dart
```