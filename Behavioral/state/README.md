# Patrón State (De Estado)

## Descripción general

El State es un patrón de diseño de comportamiento que permite que un objeto altere su comportamiento cuando su estado interno cambia. El objeto parecerá cambiar de clase: cada estado concreto encapsula la lógica correspondiente a ese estado, y el objeto contexto delega el comportamiento al estado activo.

---

## Problema

Considera un reproductor de música con tres estados: reproduciendo, pausado y detenido. Sin el patrón, el comportamiento de cada método depende del estado actual mediante condicionales que crecen con cada nuevo estado.

**Enfoque incorrecto (condicionales por estado):**

```dart
void pressPlay() {
  if (state == "stopped") {
    // iniciar reproducción
  } else if (state == "paused") {
    // reanudar
  } else if (state == "playing") {
    // ignorar
  }
}
```

Agregar un nuevo estado (como "buffering") obliga a modificar todos los métodos del reproductor.

**Enfoque correcto usando State:**

```dart
player.pressPlay();  // el reproductor delega al estado actual
player.pressPause();
player.pressStop();
```

Cada estado sabe qué hacer ante cada acción, y el contexto simplemente delega.

---

## Estructura

| Componente | Rol |
|---|---|
| State | Interfaz que declara los métodos que varían según el estado |
| Concrete State | Implementa el comportamiento correspondiente a un estado específico |
| Context | Mantiene la referencia al estado actual y delega las operaciones |
| Client | Interactúa con el Context sin conocer los estados internos |

---

## Implementación en Dart

**`state/player_state.dart`**

```dart
// Importación anticipada para evitar dependencia circular
import '../context/music_player.dart';

abstract class PlayerState {
  void pressPlay(MusicPlayer player);
  void pressPause(MusicPlayer player);
  void pressStop(MusicPlayer player);
}
```

**`context/music_player.dart`**

```dart
import '../state/player_state.dart';
import '../state/stopped_state.dart';

class MusicPlayer {
  late PlayerState _state;
  String currentTrack = "Sin pista";

  MusicPlayer() {
    _state = StoppedState();
  }

  void setState(PlayerState state) => _state = state;

  void pressPlay() => _state.pressPlay(this);
  void pressPause() => _state.pressPause(this);
  void pressStop() => _state.pressStop(this);
}
```

**`state/stopped_state.dart`**

```dart
import 'player_state.dart';
import '../context/music_player.dart';
import 'playing_state.dart';

class StoppedState implements PlayerState {
  @override
  void pressPlay(MusicPlayer player) {
    print("▶ Iniciando reproducción de '${player.currentTrack}'...");
    player.setState(PlayingState());
  }

  @override
  void pressPause(MusicPlayer player) {
    print("⚠ No hay reproducción en curso para pausar.");
  }

  @override
  void pressStop(MusicPlayer player) {
    print("⚠ El reproductor ya está detenido.");
  }
}
```

**`state/playing_state.dart`**

```dart
import 'player_state.dart';
import '../context/music_player.dart';
import 'paused_state.dart';
import 'stopped_state.dart';

class PlayingState implements PlayerState {
  @override
  void pressPlay(MusicPlayer player) {
    print("⚠ Ya se está reproduciendo '${player.currentTrack}'.");
  }

  @override
  void pressPause(MusicPlayer player) {
    print("⏸ Pausando reproducción...");
    player.setState(PausedState());
  }

  @override
  void pressStop(MusicPlayer player) {
    print("⏹ Deteniendo reproducción...");
    player.setState(StoppedState());
  }
}
```

**`state/paused_state.dart`**

```dart
import 'player_state.dart';
import '../context/music_player.dart';
import 'playing_state.dart';
import 'stopped_state.dart';

class PausedState implements PlayerState {
  @override
  void pressPlay(MusicPlayer player) {
    print("▶ Reanudando reproducción de '${player.currentTrack}'...");
    player.setState(PlayingState());
  }

  @override
  void pressPause(MusicPlayer player) {
    print("⚠ La reproducción ya está pausada.");
  }

  @override
  void pressStop(MusicPlayer player) {
    print("⏹ Deteniendo desde pausa...");
    player.setState(StoppedState());
  }
}
```

**`main.dart`**

```dart
import 'context/music_player.dart';

void main() {
  final player = MusicPlayer();
  player.currentTrack = "Bohemian Rhapsody";

  player.pressPlay();
  player.pressPlay();   // sin efecto
  player.pressPause();
  player.pressPlay();   // reanuda
  player.pressStop();
  player.pressPause();  // sin efecto
}
```

**Salida esperada:**

```text
▶ Iniciando reproducción de 'Bohemian Rhapsody'...
⚠ Ya se está reproduciendo 'Bohemian Rhapsody'.
⏸ Pausando reproducción...
▶ Reanudando reproducción de 'Bohemian Rhapsody'...
⏹ Deteniendo reproducción...
⚠ No hay reproducción en curso para pausar.
```

---

## Variante avanzada: transiciones con historial

El contexto puede mantener un historial de estados para permitir retroceder al estado anterior:

```dart
class MusicPlayer {
  final List<PlayerState> _history = [];
  late PlayerState _state;

  void setState(PlayerState state) {
    _history.add(_state);
    _state = state;
  }

  void revertState() {
    if (_history.isNotEmpty) {
      _state = _history.removeLast();
      print("Estado revertido.");
    }
  }
}
```

Esto permite implementar un "deshacer" sobre las transiciones de estado sin modificar los estados concretos.

---

## Ventajas y desventajas

**Ventajas**
- Elimina condicionales extensos basados en el estado actual del objeto
- Cada estado encapsula su propio comportamiento, cumpliendo el Principio de Responsabilidad Única
- Agregar nuevos estados no requiere modificar los existentes (Principio Abierto/Cerrado)
- Las transiciones de estado son explícitas y fáciles de rastrear

**Desventajas**
- Puede resultar excesivo si el objeto solo tiene dos o tres estados con comportamiento simple
- Aumenta el número de clases del sistema

---

## Cuándo utilizarlo

Aplica el patrón State cuando:

- El comportamiento de un objeto depende fuertemente de su estado interno y cambia en tiempo de ejecución
- Los métodos contienen múltiples condicionales que verifican el estado del objeto
- Las transiciones entre estados son complejas o están sujetas a reglas de negocio
- Se anticipan nuevos estados en el futuro que no deben afectar el código existente

---

## Aplicaciones en Flutter

- Control de reproducción de audio o video (reproduciendo, pausado, detenido, buffering)
- Gestión del ciclo de vida de una petición de red (idle, loading, success, error)
- Flujo de autenticación de usuario (no autenticado, autenticando, autenticado, expirado)
- Estados de un formulario (vacío, editando, validando, enviado, con error)

---

## Estructura del proyecto

```
state/
│
├── state/
│   ├── player_state.dart
│   ├── stopped_state.dart
│   ├── playing_state.dart
│   └── paused_state.dart
│
├── context/
│   └── music_player.dart
│
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart run behavioral/state/main.dart
```