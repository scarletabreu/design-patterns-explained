# Patrón Memento

## Descripción general

El Memento es un patrón de diseño de comportamiento que permite capturar y restaurar el estado interno de un objeto sin violar su encapsulamiento. El estado se guarda en un objeto memento opaco que solo el originador puede leer.

Es la base de los mecanismos de deshacer/rehacer (undo/redo) en editores y aplicaciones interactivas.

---

## Problema

Considera un editor de texto donde el usuario puede escribir y necesita poder deshacer sus cambios. Si el historial de estados se gestiona desde fuera del editor, es necesario exponer todos los campos internos del editor, rompiendo su encapsulamiento.

**Enfoque sin Memento (problemático):**

```dart
// El historial accede directamente al estado interno del editor
final snapshot = editor.contenido; // expone el estado
// ...
editor.contenido = snapshot; // modifica el estado directamente desde fuera
```

El editor pierde el control sobre cómo se accede y modifica su propio estado.

**Enfoque con Memento:**

```dart
historial.push(editor.guardar()); // el editor crea el memento
editor.restaurar(historial.pop()!); // el editor restaura desde el memento
```

El estado se encapsula en el memento; el historial lo almacena sin interpretarlo.

---

## Estructura

| Componente | Rol |
|---|---|
| Originator (`Editor`) | Crea mementos de su estado y puede restaurarse desde ellos |
| Memento (`EditorMemento`) | Almacena el estado interno; solo el Originator puede leerlo |
| Caretaker (`Historial`) | Guarda y administra los mementos sin acceder a su contenido |

---

## Implementación en Dart

**1. Memento**

```dart
class EditorMemento {
  final String _contenido;

  EditorMemento(this._contenido);

  String get contenido => _contenido;
}
```

**2. Originador**

```dart
class Editor {
  String _contenido = '';

  void escribir(String texto) {
    _contenido += texto;
  }

  String get contenido => _contenido;

  EditorMemento guardar() => EditorMemento(_contenido);

  void restaurar(EditorMemento memento) {
    _contenido = memento.contenido;
  }
}
```

**3. Caretaker**

```dart
class Historial {
  final List<EditorMemento> _estados = [];

  void push(EditorMemento memento) => _estados.add(memento);

  EditorMemento? pop() => _estados.isEmpty ? null : _estados.removeLast();
}
```

**4. Uso**

```dart
void main() {
  final editor = Editor();
  final historial = Historial();

  editor.escribir('Hola');
  historial.push(editor.guardar());      // guarda estado 1

  editor.escribir(', mundo');
  historial.push(editor.guardar());      // guarda estado 2

  editor.escribir('!');
  print(editor.contenido);              // Hola, mundo!

  editor.restaurar(historial.pop()!);
  print(editor.contenido);              // Hola, mundo

  editor.restaurar(historial.pop()!);
  print(editor.contenido);              // Hola
}
```

**Salida esperada:**

```text
Hola, mundo!
Hola, mundo
Hola
```

---

## Ventajas y desventajas

**Ventajas**
- Implementa undo/redo sin exponer el estado interno del objeto
- Cumple el principio de responsabilidad única: el originador gestiona su estado; el caretaker gestiona el historial
- Simplifica el código del originador al centralizar la lógica de restauración

**Desventajas**
- El consumo de memoria puede crecer si el estado es grande y se guardan muchos mementos
- En lenguajes sin soporte nativo de serialización, clonar estado complejo puede ser costoso
- El caretaker no sabe cuándo un memento es obsoleto y puede acumular datos innecesarios

---

## Cuándo utilizarlo

Aplica el patrón Memento cuando:

- Se necesita implementar operaciones de deshacer/rehacer
- Se quiere tomar "instantáneas" del estado de un objeto para restaurarlo más tarde
- El acceso directo al estado del objeto violaría su encapsulamiento
- Se necesita un historial de transacciones que pueda revertirse

---

## Aplicaciones en Flutter

- Historial de edición en editores de texto o formularios complejos
- Guardado de estados de navegación para retroceder a pantallas anteriores con su estado
- Snapshots de modelos en gestores de estado (Bloc, Riverpod) para depuración o viaje en el tiempo
- Sistemas de guardado automático en aplicaciones de diseño o dibujo

---

## Estructura del proyecto

```
memento/
│
├── editor_memento.dart
├── editor.dart
├── historial.dart
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart Behavioral/memento/main.dart
```
