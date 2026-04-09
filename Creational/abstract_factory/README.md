# Patrón Abstract Factory

## Descripción general

El Abstract Factory es un patrón de diseño creacional que proporciona una interfaz para crear **familias de objetos relacionados** sin especificar sus clases concretas.

En lugar de seleccionar objetos individuales, se elige una familia completa, garantizando coherencia entre todos sus componentes.

---

## Problema

Considera una interfaz de usuario con soporte para múltiples temas:

- Tema oscuro: botón oscuro + input oscuro
- Tema claro: botón claro + input claro

**Enfoque incorrecto (mezcla inconsistente):**

```dart
final button = DarkButton();
final input = LightInput(); // combinación incoherente
```

**Enfoque correcto usando Abstract Factory:**

```dart
final factory = DarkThemeFactory();

final button = factory.createButton();
final input = factory.createInput();
```

Todos los objetos pertenecen a la misma familia de forma automática.

---

## Estructura

| Componente | Rol |
|---|---|
| Abstract Factory | Interfaz con múltiples métodos de creación |
| Concrete Factory | Crea una familia completa de objetos |
| Abstract Product | Interfaces comunes (`Button`, `Input`) |
| Concrete Product | Implementaciones específicas por familia |

---

## Implementación en Dart

**1. Productos abstractos**

```dart
abstract class Button {
  void render();
}

abstract class Input {
  void render();
}
```

**2. Productos concretos**

```dart
class DarkButton implements Button {
  @override
  void render() {
    print("Dark Button");
  }
}

class LightButton implements Button {
  @override
  void render() {
    print("Light Button");
  }
}

class DarkInput implements Input {
  @override
  void render() {
    print("Dark Input");
  }
}

class LightInput implements Input {
  @override
  void render() {
    print("Light Input");
  }
}
```

**3. Abstract Factory**

```dart
abstract class UIFactory {
  Button createButton();
  Input createInput();
}
```

**4. Factories concretas**

```dart
class DarkThemeFactory implements UIFactory {
  @override
  Button createButton() => DarkButton();

  @override
  Input createInput() => DarkInput();
}

class LightThemeFactory implements UIFactory {
  @override
  Button createButton() => LightButton();

  @override
  Input createInput() => LightInput();
}
```

**5. Uso**

```dart
void main() {
  UIFactory factory = DarkThemeFactory();

  final button = factory.createButton();
  final input = factory.createInput();

  button.render();
  input.render();
}
```

**Salida esperada:**

```text
Render Dark Button
Render Dark Input
```

---

## Ventajas y desventajas

**Ventajas**
- Garantiza coherencia entre los objetos de una misma familia
- Facilita el cambio de configuración global del sistema
- Reduce errores derivados de combinaciones inválidas entre productos

**Desventajas**
- Incrementa el número de clases en el proyecto
- Extender el sistema con nuevos tipos de productos (p. ej. `Checkbox`) requiere modificar todas las factories existentes

---

## Diferencia con Factory Method

| Factory Method | Abstract Factory |
|---|---|
| Crea un único objeto | Crea familias de objetos relacionados |
| Una sola decisión de creación | Varias decisiones coordinadas |
| Mayor simplicidad | Mayor estructura y consistencia |

---

## Cuándo utilizarlo

Aplica el patrón Abstract Factory cuando:

- Los objetos deben funcionar en conjunto y pertenecer a una misma familia
- El sistema soporta múltiples configuraciones (temas, entornos, plataformas)
- Se requiere garantizar consistencia de forma automática al cambiar de configuración

---

## Aplicaciones en Flutter

- Temas de interfaz (oscuro / claro)
- Widgets adaptativos según plataforma (iOS / Android)
- Servicios diferenciados por entorno (desarrollo / producción)

---

## Estructura del proyecto

```
abstract-factory/
│
├── factory/
│   ├── factory.dart
│   ├── dark_theme_factory.dart
│   └── light_theme_factory.dart
│
├── theme/
│   ├── dark_theme.dart
│   └── light_theme.dart
│
├── widgets/
│   ├── button.dart
│   └── input.dart
│
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart creational/abstract-factory/main.dart
```