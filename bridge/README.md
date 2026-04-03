# Patrón Bridge

## Descripción general

El Bridge es un patrón de diseño estructural que separa una abstracción de su implementación, permitiendo que ambas evolucionen de forma independiente.

En lugar de crear una jerarquía de clases que combine todas las variantes posibles, se componen dos jerarquías paralelas que se conectan mediante composición.

---

## Problema

Supón que necesitas modelar controles remotos para distintos dispositivos:

- `RemoteTV`
- `RemoteRadio`
- `AdvancedRemoteTV`
- `AdvancedRemoteRadio`

Cada nueva combinación exige una clase adicional. Este crecimiento exponencial se conoce como **explosión de clases**.

**Enfoque incorrecto (herencia combinada):**

```dart
class AdvancedRemoteTV extends RemoteTV { ... }
class AdvancedRemoteRadio extends RemoteRadio { ... }
```

**Enfoque correcto usando Bridge:**

```dart
final remote = AdvancedRemote(TV());
```

La abstracción (`Remote`) y la implementación (`Device`) se desarrollan por separado y se combinan en tiempo de ejecución.

---

## Estructura

| Componente | Rol |
|---|---|
| Abstraction | Define la interfaz del control (`RemoteControl`) |
| Refined Abstraction | Extiende la abstracción (`AdvancedRemote`) |
| Implementor | Interfaz común para los dispositivos (`Device`) |
| Concrete Implementor | Implementaciones específicas (`TV`, `Radio`) |

---

## Implementación en Dart

**`implementation/device.dart`**

```dart
abstract class Device {
  void turnOn();
  void turnOff();
  void setVolume(int volume);
}
```

**`implementation/tv.dart`**

```dart
import 'device.dart';

class TV implements Device {
  @override
  void turnOn() => print("TV encendida");

  @override
  void turnOff() => print("TV apagada");

  @override
  void setVolume(int volume) => print("TV — volumen: $volume");
}
```

**`implementation/radio.dart`**

```dart
import 'device.dart';

class Radio implements Device {
  @override
  void turnOn() => print("Radio encendida");

  @override
  void turnOff() => print("Radio apagada");

  @override
  void setVolume(int volume) => print("Radio — volumen: $volume");
}
```

**`abstraction/remote_control.dart`**

```dart
import '../implementation/device.dart';

class RemoteControl {
  final Device device;

  RemoteControl(this.device);

  void togglePower() {
    device.turnOn();
  }

  void volumeUp() {
    device.setVolume(10);
  }
}
```

**`abstraction/advanced_remote.dart`**

```dart
import 'remote_control.dart';

class AdvancedRemote extends RemoteControl {
  AdvancedRemote(super.device);

  void mute() {
    device.setVolume(0);
  }
}
```

**`main.dart`**

```dart
import 'abstraction/advanced_remote.dart';
import 'implementation/tv.dart';
import 'implementation/radio.dart';

void main() {
  final remote1 = AdvancedRemote(TV());
  remote1.togglePower();
  remote1.volumeUp();
  remote1.mute();

  print("---");

  final remote2 = AdvancedRemote(Radio());
  remote2.togglePower();
  remote2.volumeUp();
  remote2.mute();
}
```

**Salida esperada:**

```text
TV encendida
TV — volumen: 10
TV — volumen: 0
---
Radio encendida
Radio — volumen: 10
Radio — volumen: 0
```

---

## Las dos dimensiones del patrón

| Dimensión | Ejemplo |
|---|---|
| Abstracción (qué se hace) | `RemoteControl`, `AdvancedRemote` |
| Implementación (sobre qué) | `TV`, `Radio` |

Agregar un nuevo dispositivo no requiere modificar ningún control remoto, y viceversa. Ambas jerarquías son completamente independientes.

---

## Ventajas y desventajas

**Ventajas**
- Elimina la explosión de clases derivada de combinar múltiples dimensiones
- Permite extender abstracciones e implementaciones de forma independiente
- Favorece la composición sobre la herencia
- Sigue el Principio Abierto/Cerrado y el Principio de Responsabilidad Única

**Desventajas**
- Introduce mayor complejidad estructural en sistemas simples
- La relación entre abstracción e implementación puede resultar menos evidente para quien lee el código por primera vez

---

## Cuándo utilizarlo

Aplica el patrón Bridge cuando:

- Una clase presenta dos o más dimensiones de variación independientes
- Se requiere cambiar la implementación en tiempo de ejecución
- Se quiere evitar una jerarquía de herencia con crecimiento exponencial

---

## Aplicaciones en Flutter

- Renderizado de widgets con distintos motores gráficos
- Notificaciones con múltiples canales (push, email, SMS) y múltiples plantillas
- Servicios de almacenamiento intercambiables (local, remoto) usados por la misma lógica de negocio

---

## Estructura del proyecto

```
bridge/
│
├── abstraction/
│   ├── remote_control.dart
│   └── advanced_remote.dart
│
├── implementation/
│   ├── device.dart
│   ├── tv.dart
│   └── radio.dart
│
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart bridge/main.dart
```
```