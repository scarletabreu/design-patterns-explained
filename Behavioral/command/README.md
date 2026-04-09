# Patrón Command (Comando)

## Descripción general

El Command es un patrón de diseño de comportamiento que convierte una solicitud en un objeto independiente que contiene toda la información necesaria para ejecutar dicha acción. Esta encapsulación permite parametrizar métodos con diferentes solicitudes, encolar o registrar operaciones, y soportar operaciones reversibles (undo/redo).

---

## Problema

Considera una aplicación con botones de interfaz gráfica que ejecutan acciones distintas: guardar un archivo, copiar texto, deshacer un cambio. Si cada botón conoce directamente el objeto receptor y llama sus métodos, el código queda fuertemente acoplado y es difícil de extender o reutilizar.

**Enfoque incorrecto (acoplamiento directo):**

```dart
// El botón conoce directamente al editor y llama sus métodos
button.onClick = () => editor.copy();
button2.onClick = () => editor.paste();
```

Este enfoque impide reutilizar los botones para distintos receptores y hace imposible implementar historial de operaciones.

**Enfoque correcto usando Command:**

```dart
button.setCommand(CopyCommand(editor));
button2.setCommand(PasteCommand(editor));

button.click(); // Ejecuta el comando sin conocer el receptor
```

Cada acción es un objeto: puede almacenarse, encolarse, revertirse o ejecutarse de forma diferida.

---

## Estructura

| Componente | Rol |
|---|---|
| Command | Interfaz con el método `execute()` (y opcionalmente `undo()`) |
| Concrete Command | Implementa la acción concreta y mantiene referencia al Receiver |
| Receiver | Objeto que sabe cómo realizar la operación real |
| Invoker | Almacena y dispara el comando sin conocer su implementación |
| Client | Crea los comandos concretos y los asigna al Invoker |

---

## Implementación en Dart

**`receiver/text_editor.dart`**

```dart
class TextEditor {
  String _content = "";

  String get content => _content;

  void write(String text) {
    _content += text;
    print("Editor: contenido actual → '$_content'");
  }

  void erase(int charCount) {
    if (charCount > _content.length) charCount = _content.length;
    _content = _content.substring(0, _content.length - charCount);
    print("Editor: contenido actual → '$_content'");
  }
}
```

**`command/command.dart`**

```dart
abstract class Command {
  void execute();
  void undo();
}
```

**`command/write_command.dart`**

```dart
import '../receiver/text_editor.dart';
import 'command.dart';

class WriteCommand implements Command {
  final TextEditor _editor;
  final String _text;

  WriteCommand(this._editor, this._text);

  @override
  void execute() => _editor.write(_text);

  @override
  void undo() => _editor.erase(_text.length);
}
```

**`command/erase_command.dart`**

```dart
import '../receiver/text_editor.dart';
import 'command.dart';

class EraseCommand implements Command {
  final TextEditor _editor;
  final int _charCount;
  String _erasedText = "";

  EraseCommand(this._editor, this._charCount);

  @override
  void execute() {
    final content = _editor.content;
    final start = (content.length - _charCount).clamp(0, content.length);
    _erasedText = content.substring(start);
    _editor.erase(_charCount);
  }

  @override
  void undo() => _editor.write(_erasedText);
}
```

**`invoker/command_history.dart`**

```dart
import '../command/command.dart';

class CommandHistory {
  final List<Command> _history = [];

  void executeCommand(Command command) {
    command.execute();
    _history.add(command);
  }

  void undoLast() {
    if (_history.isEmpty) {
      print("No hay comandos que deshacer.");
      return;
    }
    final last = _history.removeLast();
    last.undo();
  }
}
```

**`main.dart`**

```dart
import 'receiver/text_editor.dart';
import 'command/write_command.dart';
import 'command/erase_command.dart';
import 'invoker/command_history.dart';

void main() {
  final editor = TextEditor();
  final history = CommandHistory();

  history.executeCommand(WriteCommand(editor, "Hola"));
  history.executeCommand(WriteCommand(editor, " Mundo"));
  history.executeCommand(EraseCommand(editor, 5));

  print("\n--- Deshaciendo operaciones ---");
  history.undoLast();
  history.undoLast();
}
```

**Salida esperada:**

```text
Editor: contenido actual → 'Hola'
Editor: contenido actual → 'Hola Mundo'
Editor: contenido actual → 'Hola'

--- Deshaciendo operaciones ---
Editor: contenido actual → 'Hola Mundo'
Editor: contenido actual → 'Hola'
```

---

## El Invoker con cola de comandos (variante avanzada)

El Invoker puede actuar como una cola de macros, ejecutando múltiples comandos en secuencia o en diferido:

```dart
class MacroCommand implements Command {
  final List<Command> _commands;

  MacroCommand(this._commands);

  @override
  void execute() {
    for (final cmd in _commands) {
      cmd.execute();
    }
  }

  @override
  void undo() {
    for (final cmd in _commands.reversed) {
      cmd.undo();
    }
  }
}
```

Con macros, múltiples acciones se agrupan como una sola unidad reversible:

```dart
final macro = MacroCommand([
  WriteCommand(editor, "Título"),
  WriteCommand(editor, "\n"),
  WriteCommand(editor, "Contenido del documento"),
]);

history.executeCommand(macro);
history.undoLast(); // Deshace las tres escrituras en orden inverso
```

---

## Ventajas y desventajas

**Ventajas**
- Desacopla el objeto que invoca la operación del que sabe cómo realizarla
- Permite implementar operaciones reversibles (undo/redo) con facilidad
- Facilita el encolado, registro y ejecución diferida de operaciones
- Soporta la composición de comandos en macros o transacciones

**Desventajas**
- Incrementa el número de clases, una por cada operación concreta
- Puede volverse complejo si se necesita mantener el estado previo para el undo

---

## Cuándo utilizarlo

Aplica el patrón Command cuando:

- Se necesita parametrizar objetos con operaciones (botones, atajos de teclado)
- Se requiere soporte para deshacer y rehacer acciones
- Se desea encolar operaciones para ejecución asíncrona o diferida
- Se necesita implementar transacciones reversibles

---

## Aplicaciones en Flutter

- Acciones de botones en toolbars y menús contextuales
- Sistema de undo/redo en editores de texto o de diseño
- Gestión de formularios con validaciones por pasos
- Operaciones sobre listas de elementos (eliminar, mover, editar) con posibilidad de deshacer

---

## Estructura del proyecto

```
command/
│
├── command/
│   ├── command.dart
│   ├── write_command.dart
│   └── erase_command.dart
│
├── receiver/
│   └── text_editor.dart
│
├── invoker/
│   └── command_history.dart
│
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart run behavioral/command/main.dart
```
