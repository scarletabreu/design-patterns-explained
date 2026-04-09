# Patrón Observer (Observador)

## Descripción general

El Observer es un patrón de diseño de comportamiento que define una dependencia uno-a-muchos entre objetos: cuando el sujeto cambia su estado, todos sus observadores son notificados y actualizados automáticamente.

Implementa la base de los sistemas de eventos, streams reactivos y la arquitectura publish-subscribe.

---

## Problema

Considera una estación meteorológica que necesita mostrar la temperatura en múltiples pantallas y activar alertas cuando se supera cierto umbral. Si la estación conoce y llama directamente a cada pantalla y alerta, queda fuertemente acoplada a sus consumidores; añadir uno nuevo implica modificar la estación.

**Enfoque sin Observer (problemático):**

```dart
class EstacionMeteorologica {
  void nuevaLectura(double temperatura) {
    pantallaCelsius.mostrar(temperatura);
    alertaCalor.evaluar(temperatura);
    // añadir una pantalla nueva requiere modificar esta clase
  }
}
```

La estación depende de todos sus consumidores y viola el principio abierto/cerrado.

**Enfoque con Observer:**

```dart
estacion.suscribir(PantallaCelsius());
estacion.suscribir(AlertaCalor());

estacion.nuevaLectura(36.7); // notifica a todos automáticamente
```

La estación solo conoce la interfaz `Observador`; no sabe quiénes están suscritos.

---

## Estructura

| Componente | Rol |
|---|---|
| Observer (`Observador<T>`) | Interfaz con el método `actualizar(T dato)` |
| Subject (`Sujeto<T>`) | Mantiene la lista de observadores y los notifica |
| Concrete Subject (`EstacionMeteorologica`) | Extiende Subject y dispara notificaciones ante cambios |
| Concrete Observers | Implementan la reacción a las notificaciones |

---

## Implementación en Dart

**1. Interfaz Observer**

```dart
abstract class Observador<T> {
  void actualizar(T dato);
}
```

**2. Clase Subject genérica**

```dart
class Sujeto<T> {
  final List<Observador<T>> _observadores = [];

  void suscribir(Observador<T> observador) {
    _observadores.add(observador);
  }

  void desuscribir(Observador<T> observador) {
    _observadores.remove(observador);
  }

  void notificar(T dato) {
    for (final o in _observadores) {
      o.actualizar(dato);
    }
  }
}
```

**3. Sujeto concreto**

```dart
class EstacionMeteorologica extends Sujeto<double> {
  double _temperatura = 0;

  void nuevaLectura(double temperatura) {
    _temperatura = temperatura;
    notificar(_temperatura);
  }
}
```

**4. Observadores concretos**

```dart
class PantallaCelsius implements Observador<double> {
  @override
  void actualizar(double dato) {
    print('Pantalla: ${dato.toStringAsFixed(1)} °C');
  }
}

class AlertaCalor implements Observador<double> {
  @override
  void actualizar(double dato) {
    if (dato > 35) print('¡Alerta de calor extremo!');
  }
}
```

**5. Uso**

```dart
void main() {
  final estacion = EstacionMeteorologica();
  estacion.suscribir(PantallaCelsius());
  estacion.suscribir(AlertaCalor());

  estacion.nuevaLectura(28.4);
  estacion.nuevaLectura(36.7);
}
```

**Salida esperada:**

```text
Pantalla: 28.4 °C
Pantalla: 36.7 °C
¡Alerta de calor extremo!
```

---

## Variante: Streams de Dart

Dart tiene soporte nativo para el patrón Observer a través de `Stream` y `StreamController`:

```dart
final controller = StreamController<double>.broadcast();

controller.stream.listen((t) => print('Pantalla: $t °C'));
controller.stream.listen((t) { if (t > 35) print('¡Alerta!'); });

controller.add(28.4);
controller.add(36.7);
```

Para casos simples, los Streams de Dart son preferibles por su integración con `async`/`await` y `StreamBuilder` en Flutter.

---

## Ventajas y desventajas

**Ventajas**
- Desacopla el sujeto de sus observadores: no necesitan conocerse mutuamente
- Cumple el principio abierto/cerrado: se añaden observadores sin modificar el sujeto
- Permite comunicación broadcast (uno a muchos) de forma sencilla
- Los observadores pueden suscribirse y desuscribirse en tiempo de ejecución

**Desventajas**
- Si hay muchos observadores o notificaciones frecuentes, el rendimiento puede verse afectado
- El orden de notificación no está garantizado sin lógica adicional
- Observadores que no se desuscriben pueden provocar fugas de memoria

---

## Cuándo utilizarlo

Aplica el patrón Observer cuando:

- Un cambio en un objeto debe desencadenar cambios en otros sin conocerlos directamente
- Se necesita un mecanismo de eventos o pub-sub entre componentes desacoplados
- El número de objetos que reaccionan a un evento puede variar en tiempo de ejecución
- Se implementa la capa de reactividad en una arquitectura MVC, MVP o MVVM

---

## Aplicaciones en Flutter

- `ChangeNotifier` y `ValueNotifier` son implementaciones del patrón Observer
- `Stream` y `StreamController` para flujos de datos reactivos
- `BLoC` usa Streams para notificar a la UI de cambios de estado
- `Riverpod` y `Provider` exponen el patrón Observer para reconstrucción de widgets

---

## Estructura del proyecto

```
observer/
│
├── observador.dart
├── sujeto.dart
├── estacion_meteorologica.dart
├── pantalla_celsius.dart
├── alerta_calor.dart
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart Behavioral/observer/main.dart
```
