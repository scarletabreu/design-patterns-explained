# Patrón Facade

## Descripción general

El Facade proporciona una **interfaz simple para sistemas complejos**.

------------------------------------------------------------------------

## Problema

Sistema de cine en casa con múltiples componentes:

-   DVD
-   Proyector
-   Amplificador
-   Luces

Uso directo es complejo.

------------------------------------------------------------------------

## Solución

Encapsular todo en una sola clase:

``` dart
homeTheater.watchMovie();
```

------------------------------------------------------------------------

## Estructura

  Componente   Rol
  ------------ -----------------
  Facade       Interfaz simple
  Subsystem    Clases internas

------------------------------------------------------------------------

## Implementación en Dart

**dvd_player.dart**

``` dart
class DVDPlayer {
  void on() => print("DVD encendido");
  void play() => print("Reproduciendo película");
}
```

**projector.dart**

``` dart
class Projector {
  void on() => print("Proyector encendido");
}
```

**amplifier.dart**

``` dart
class Amplifier {
  void on() => print("Amplificador encendido");
  void setVolume(int volume) => print("Volumen en $volume");
}
```

**lights.dart**

``` dart
class Lights {
  void dim() => print("Luces atenuadas");
}
```

**home_theater_facade.dart**

``` dart
import '../subsystem/dvd_player.dart';
import '../subsystem/projector.dart';
import '../subsystem/amplifier.dart';
import '../subsystem/lights.dart';

class HomeTheaterFacade {
  final DVDPlayer dvd;
  final Projector projector;
  final Amplifier amplifier;
  final Lights lights;

  HomeTheaterFacade(this.dvd, this.projector, this.amplifier, this.lights);

  void watchMovie() {
    print("Preparando cine en casa...");
    lights.dim();
    projector.on();
    amplifier.on();
    amplifier.setVolume(10);
    dvd.on();
    dvd.play();
  }
}
```

**main.dart**

``` dart
import 'facade/home_theater_facade.dart';
import 'subsystem/dvd_player.dart';
import 'subsystem/projector.dart';
import 'subsystem/amplifier.dart';
import 'subsystem/lights.dart';

void main() {
  final facade = HomeTheaterFacade(
    DVDPlayer(),
    Projector(),
    Amplifier(),
    Lights(),
  );

  facade.watchMovie();
}
```

------------------------------------------------------------------------

## Ventajas y desventajas

**Ventajas** - Simplifica uso - Reduce acoplamiento

**Desventajas** - Puede crecer demasiado

------------------------------------------------------------------------

## Cuándo usarlo

-   Sistemas complejos
-   Necesidad de simplificación

------------------------------------------------------------------------

## Estructura del proyecto

    facade/
    ├── facade/
    ├── subsystem/
    ├── main.dart

------------------------------------------------------------------------

## Ejecución

``` bash
dart structural/facade/main.dart
```
