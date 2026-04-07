# Patrón Prototype

## Descripción general

El Prototype es un patrón de diseño creacional que permite crear nuevos objetos clonando una instancia existente (el "prototipo"), en lugar de construirlos desde cero.

Esto es útil cuando la creación de un objeto es costosa o compleja, y se necesitan múltiples copias con variaciones menores.

---

## Problema

Considera un sistema de notificaciones donde se envían correos, notificaciones push y SMS. Muchas notificaciones comparten la misma estructura base (tipo, plantilla, metadatos) y solo varían en el destinatario o en pequeños detalles.

**Enfoque sin Prototype (problemático):**

```dart
final notif1 = Notification(
  tipo: 'email',
  titulo: 'Bienvenido a nuestra plataforma',
  mensaje: 'Gracias por registrarte...',
  destinatario: 'usuario1@ejemplo.com',
  metadatos: {'prioridad': 'normal', 'categoria': 'onboarding'},
);

// Repetir toda la configuración para cada usuario...
final notif2 = Notification(
  tipo: 'email',
  titulo: 'Bienvenido a nuestra plataforma',
  mensaje: 'Gracias por registrarte...',
  destinatario: 'usuario2@ejemplo.com',
  metadatos: {'prioridad': 'normal', 'categoria': 'onboarding'},
);
```

Esto genera código duplicado y es propenso a errores cuando la plantilla cambia.

**Enfoque con Prototype:**

```dart
final clon = plantillaEmail.clone();
clon.destinatario = 'usuario2@ejemplo.com';
```

Se clona la plantilla base y solo se modifican los campos necesarios.

---

## Estructura

| Componente | Rol |
|---|---|
| Prototype | Interfaz con el método `clone()` |
| Producto concreto | Clase que implementa `clone()` (`Notification`) |
| Registro (opcional) | Almacena prototipos y devuelve clones bajo demanda (`NotificationRegistry`) |

---

## Implementación en Dart

**1. Interfaz Prototype**

```dart
abstract class Prototype<T> {
  T clone();
}
```

**2. Producto concreto**

```dart
class Notification implements Prototype<Notification> {
  String tipo;
  String titulo;
  String mensaje;
  String destinatario;
  Map<String, String> metadatos;

  Notification({ ... });

  @override
  Notification clone() {
    return Notification(
      tipo: tipo,
      titulo: titulo,
      mensaje: mensaje,
      destinatario: destinatario,
      metadatos: Map<String, String>.from(metadatos), // copia profunda
    );
  }
}
```

> **Nota:** Es fundamental hacer copia profunda de los campos mutables (como `Map` y `List`) para que los clones sean verdaderamente independientes del original.

**3. Registro de prototipos**

```dart
class NotificationRegistry {
  final Map<String, Notification> _plantillas = {};

  void registrar(String clave, Notification plantilla) {
    _plantillas[clave] = plantilla;
  }

  Notification obtenerClon(String clave) {
    final plantilla = _plantillas[clave];
    if (plantilla == null) {
      throw ArgumentError('No existe una plantilla con la clave: $clave');
    }
    return plantilla.clone();
  }
}
```

**4. Uso**

```dart
void main() {
  final registro = NotificationRegistry();
  registro.registrar('bienvenida', plantillaEmail);

  final notif = registro.obtenerClon('bienvenida');
  notif.destinatario = 'usuario@ejemplo.com';
}
```

---

## Ventajas y desventajas

**Ventajas**
- Elimina la duplicación al crear objetos similares
- Evita subclases innecesarias para variantes de un mismo objeto
- Permite agregar y eliminar prototipos en tiempo de ejecución
- Reduce el costo de inicialización de objetos complejos

**Desventajas**
- Clonar objetos con referencias circulares puede ser complejo
- Requiere implementar `clone()` correctamente con copias profundas
- Puede ocultar la complejidad de la construcción del objeto

---

## Cuándo utilizarlo

Aplica el patrón Prototype cuando:

- Se necesitan crear muchas instancias similares con pequeñas variaciones
- La creación directa de un objeto es costosa (lectura de BD, parsing, etc.)
- Se quiere evitar una jerarquía de fábricas paralela a la de productos
- Los prototipos deben poder configurarse en tiempo de ejecución

---

## Aplicaciones en Flutter

- Clonar configuraciones de widgets para variantes de tema (modo claro/oscuro)
- Duplicar modelos de datos al editar formularios (mantener el original intacto)
- Crear plantillas de estado en gestores como Bloc o Riverpod
- Generar múltiples instancias de configuración de red con variaciones menores

---

## Estructura del proyecto

```
prototype/
│
├── prototype.dart
├── notification.dart
├── notification_registry.dart
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart Creational/prototype/main.dart
```
