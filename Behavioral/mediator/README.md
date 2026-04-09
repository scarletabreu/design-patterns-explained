# Patrón Mediator (Mediador)

## Descripción general

El Mediator es un patrón de diseño de comportamiento que reduce el acoplamiento directo entre componentes haciendo que no se comuniquen entre sí directamente, sino a través de un objeto mediador centralizado. Esto simplifica las dependencias y facilita la coordinación entre múltiples componentes.

---

## Problema

Considera un formulario de registro con varios componentes: un campo de nombre, un campo de correo, una casilla de términos y un botón de envío. Si cada componente conoce y controla a los demás directamente, se forma una red densa de dependencias que es difícil de mantener y extender.

**Enfoque incorrecto (comunicación directa entre componentes):**

```dart
// El botón conoce al campo y a la casilla directamente
submitButton.enabled = nameField.isNotEmpty &&
                       emailField.isNotEmpty &&
                       termsCheckbox.isChecked;
```

Agregar un nuevo campo requiere modificar la lógica del botón, y viceversa.

**Enfoque correcto usando Mediator:**

```dart
// Cada componente notifica al mediador; el mediador coordina el estado
nameField.onChange = () => mediator.notify(nameField, "changed");
termsCheckbox.onChange = () => mediator.notify(termsCheckbox, "changed");

// El mediador decide si habilitar el botón
mediator.notify(component, event);
```

Ningún componente conoce a los demás; toda la lógica de coordinación vive en el mediador.

---

## Estructura

| Componente | Rol |
|---|---|
| Mediator | Interfaz que declara el método de notificación entre componentes |
| Concrete Mediator | Implementa la lógica de coordinación y mantiene referencias a los componentes |
| Component | Clase base para los componentes; mantiene una referencia al mediador |
| Concrete Components | Componentes individuales que se comunican solo a través del mediador |

---

## Implementación en Dart

**`mediator/mediator.dart`**

```dart
abstract class Mediator {
  void notify(Object sender, String event);
}
```

**`component/component.dart`**

```dart
import '../mediator/mediator.dart';

abstract class Component {
  late Mediator mediator;

  void setMediator(Mediator m) => mediator = m;
}
```

**`component/input_field.dart`**

```dart
import 'component.dart';

class InputField extends Component {
  final String name;
  String value = "";

  InputField(this.name);

  void setValue(String val) {
    value = val;
    print("$name: valor actualizado → '$value'");
    mediator.notify(this, "changed");
  }

  bool get isValid => value.trim().isNotEmpty;
}
```

**`component/checkbox.dart`**

```dart
import 'component.dart';

class Checkbox extends Component {
  final String name;
  bool checked = false;

  Checkbox(this.name);

  void toggle() {
    checked = !checked;
    print("$name: ${checked ? 'marcado' : 'desmarcado'}");
    mediator.notify(this, "toggled");
  }
}
```

**`component/submit_button.dart`**

```dart
import 'component.dart';

class SubmitButton extends Component {
  bool enabled = false;

  void updateState(bool isEnabled) {
    enabled = isEnabled;
    print("Botón de envío: ${enabled ? 'habilitado' : 'deshabilitado'}");
  }

  void click() {
    if (!enabled) {
      print("Botón deshabilitado. Completa el formulario.");
      return;
    }
    mediator.notify(this, "clicked");
  }
}
```

**`mediator/form_mediator.dart`**

```dart
import '../mediator/mediator.dart';
import '../component/input_field.dart';
import '../component/checkbox.dart';
import '../component/submit_button.dart';

class FormMediator implements Mediator {
  final InputField nameField;
  final InputField emailField;
  final Checkbox termsCheckbox;
  final SubmitButton submitButton;

  FormMediator({
    required this.nameField,
    required this.emailField,
    required this.termsCheckbox,
    required this.submitButton,
  }) {
    nameField.setMediator(this);
    emailField.setMediator(this);
    termsCheckbox.setMediator(this);
    submitButton.setMediator(this);
  }

  @override
  void notify(Object sender, String event) {
    if (event == "changed" || event == "toggled") {
      _updateSubmitButton();
    }

    if (event == "clicked") {
      print("\nFormulario enviado correctamente.");
      print("  Nombre: ${nameField.value}");
      print("  Correo: ${emailField.value}");
    }
  }

  void _updateSubmitButton() {
    final canSubmit =
        nameField.isValid && emailField.isValid && termsCheckbox.checked;
    submitButton.updateState(canSubmit);
  }
}
```

**`main.dart`**

```dart
import 'component/input_field.dart';
import 'component/checkbox.dart';
import 'component/submit_button.dart';
import 'mediator/form_mediator.dart';

void main() {
  final nameField = InputField("Nombre");
  final emailField = InputField("Correo");
  final termsCheckbox = Checkbox("Términos y condiciones");
  final submitButton = SubmitButton();

  FormMediator(
    nameField: nameField,
    emailField: emailField,
    termsCheckbox: termsCheckbox,
    submitButton: submitButton,
  );

  nameField.setValue("Ana García");
  emailField.setValue("ana@ejemplo.com");
  termsCheckbox.toggle();

  print("\n--- Intentando enviar ---");
  submitButton.click();
}
```

**Salida esperada:**

```text
Nombre: valor actualizado → 'Ana García'
Botón de envío: deshabilitado
Correo: valor actualizado → 'ana@ejemplo.com'
Botón de envío: deshabilitado
Términos y condiciones: marcado
Botón de envío: habilitado

--- Intentando enviar ---
Formulario enviado correctamente.
  Nombre: Ana García
  Correo: ana@ejemplo.com
```

---

## Variante avanzada: Mediador como bus de eventos

El mediador puede generalizarse para actuar como un bus de eventos tipado, desacoplando aún más los componentes:

```dart
class EventBus implements Mediator {
  final Map<String, List<Function(Object)>> _handlers = {};

  void on(String event, Function(Object sender) handler) {
    _handlers.putIfAbsent(event, () => []).add(handler);
  }

  @override
  void notify(Object sender, String event) {
    for (final handler in _handlers[event] ?? []) {
      handler(sender);
    }
  }
}
```

Con esto, los componentes suscriben manejadores a eventos sin conocer quién los dispara:

```dart
final bus = EventBus();
bus.on("changed", (_) => print("Algo cambió en el formulario"));
bus.on("clicked", (_) => print("Formulario enviado"));
```

---

## Ventajas y desventajas

**Ventajas**
- Elimina las dependencias directas entre componentes, reduciendo el acoplamiento
- Centraliza la lógica de coordinación, haciendo más fácil su mantenimiento y comprensión
- Facilita la reutilización de componentes al independizarlos entre sí
- Simplifica la adición de nuevos componentes sin modificar los existentes

**Desventajas**
- El mediador puede convertirse en un "god object" si absorbe demasiada lógica
- Introduce una clase adicional que puede ser compleja de mantener en sistemas grandes

---

## Cuándo utilizarlo

Aplica el patrón Mediator cuando:

- Múltiples componentes se comunican entre sí y generan dependencias cruzadas difíciles de gestionar
- Se desea centralizar la lógica de coordinación en un único lugar
- Los cambios en un componente afectan el estado de otros y esa lógica es compleja
- Se necesita reutilizar componentes individuales en distintos contextos

---

## Aplicaciones en Flutter

- Coordinación de campos en formularios complejos (habilitación, validación cruzada)
- Gestión de estado compartido entre widgets independientes con BLoC o Notifiers
- Sistemas de chat o notificaciones donde múltiples participantes se comunican
- Controladores de pantalla que coordinan múltiples sub-widgets

---

## Estructura del proyecto

```
mediator/
│
├── mediator/
│   ├── mediator.dart
│   └── form_mediator.dart
│
├── component/
│   ├── component.dart
│   ├── input_field.dart
│   ├── checkbox.dart
│   └── submit_button.dart
│
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart run behavioral/mediator/main.dart
```