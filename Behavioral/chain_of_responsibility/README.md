# Patrón Chain of Responsibility (Cadena de Responsabilidad)

## Descripción general

Chain of Responsibility es un patrón de diseño de comportamiento que permite pasar solicitudes a lo largo de una cadena de manejadores. Cada manejador decide si procesa la solicitud o la pasa al siguiente eslabón de la cadena.

Esto desacopla al emisor de la solicitud de sus receptores, ya que ninguno de los dos sabe de antemano quién terminará procesándola.

---

## Problema

Considera un sistema de soporte técnico con distintos niveles de atención: soporte básico, soporte avanzado e ingeniería. Si un único componente conoce todos los niveles y decide cuál debe actuar, cualquier cambio en la lógica de escalamiento o la adición de un nuevo nivel requiere modificar ese componente central.

**Enfoque sin Chain of Responsibility (problemático):**

```dart
void manejarSolicitud(SolicitudSoporte s) {
  if (s.nivel == 1) {
    soporteNivel1.resolver(s);
  } else if (s.nivel == 2) {
    soporteNivel2.resolver(s);
  } else {
    ingenieria.resolver(s);
  }
}
```

Añadir un nuevo nivel o cambiar las reglas de escalamiento obliga a modificar esta función.

**Enfoque con Chain of Responsibility:**

```dart
final n1 = SoporteNivel1();
n1.encadenar(SoporteNivel2()).encadenar(SoporteIngenieria());

n1.manejar(solicitud); // cada eslabón decide si actúa o pasa la solicitud
```

Cada manejador solo conoce su propia lógica y al siguiente en la cadena.

---

## Estructura

| Componente | Rol |
|---|---|
| Handler (`Manejador`) | Clase base que define la interfaz y la referencia al siguiente manejador |
| Concrete Handlers | Implementan la lógica propia y delegan al siguiente si no pueden manejar |
| Client (`main`) | Construye la cadena y envía solicitudes al primer eslabón |

---

## Implementación en Dart

**1. Clase base del manejador**

```dart
abstract class Manejador {
  Manejador? _siguiente;

  Manejador encadenar(Manejador siguiente) {
    _siguiente = siguiente;
    return siguiente; // permite encadenar fluido
  }

  void manejar(SolicitudSoporte solicitud) {
    if (_siguiente != null) {
      _siguiente!.manejar(solicitud);
    } else {
      print('Solicitud sin resolver: ${solicitud.descripcion}');
    }
  }
}
```

**2. Manejadores concretos**

```dart
class SoporteNivel1 extends Manejador {
  @override
  void manejar(SolicitudSoporte solicitud) {
    if (solicitud.nivel <= 1) {
      print('Nivel 1 resuelve: ${solicitud.descripcion}');
    } else {
      super.manejar(solicitud); // pasa al siguiente
    }
  }
}

class SoporteIngenieria extends Manejador {
  @override
  void manejar(SolicitudSoporte solicitud) {
    if (solicitud.nivel >= 3) {
      print('Ingeniería resuelve: ${solicitud.descripcion}');
    } else {
      super.manejar(solicitud);
    }
  }
}
```

**3. Construcción de la cadena y uso**

```dart
void main() {
  final n1 = SoporteNivel1();
  n1.encadenar(SoporteNivel2()).encadenar(SoporteIngenieria());

  n1.manejar(SolicitudSoporte('Olvidé mi contraseña', 1));
  n1.manejar(SolicitudSoporte('Error en facturación', 2));
  n1.manejar(SolicitudSoporte('Caída del servidor', 3));
}
```

**Salida esperada:**

```text
Nivel 1 resuelve: Olvidé mi contraseña
Nivel 2 resuelve: Error en facturación
Ingeniería resuelve: Caída del servidor
```

---

## Ventajas y desventajas

**Ventajas**
- Desacopla al emisor de la solicitud de sus posibles receptores
- Aplica el principio de responsabilidad única: cada manejador tiene una sola razón para cambiar
- Aplica el principio abierto/cerrado: se pueden añadir nuevos manejadores sin modificar los existentes
- El orden y la composición de la cadena pueden cambiarse en tiempo de ejecución

**Desventajas**
- No garantiza que la solicitud sea procesada: puede llegar al final sin ser atendida
- En cadenas largas, depurar el flujo de una solicitud puede ser difícil
- Si muchos manejadores inspeccionan la solicitud sin procesarla, el rendimiento puede degradarse

---

## Cuándo utilizarlo

Aplica el patrón Chain of Responsibility cuando:

- Más de un objeto puede manejar una solicitud y el manejador no se conoce de antemano
- Se quiere enviar una solicitud a uno de varios objetos sin especificar cuál
- Los manejadores deben determinarse dinámicamente
- Se implementan sistemas de validación, filtros o pipelines donde cada paso actúa sobre el resultado anterior

---

## Aplicaciones en Flutter

- Pipelines de validación de formularios donde cada regla es un eslabón
- Middlewares de navegación que verifican autenticación, permisos y estado de la app antes de navegar
- Cadenas de interceptores HTTP (similar a `Interceptor` en Dio)
- Sistemas de manejo de errores escalonados: red → caché → fallback

---

## Estructura del proyecto

```
chain_of_responsibility/
│
├── solicitud_soporte.dart
├── manejador.dart
├── soporte_nivel1.dart
├── soporte_nivel2.dart
├── soporte_ingenieria.dart
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart Behavioral/chain_of_responsibility/main.dart
```
