# Design Patterns Explained

Repositorio de referencia práctica para aprender y aplicar **patrones de diseño de software** usando Dart. Cada patrón está implementado con un ejemplo limpio, real y documentado, siguiendo los principios **SOLID**.

---

## Estructura del repositorio
```
design-patterns-explained/
│
├── Creational/    # Creación de objetos y gestión de instancias
├── Structural/    # Composición de clases y estructuras
└── Behavioral/    # Comunicación y algoritmos entre objetos
```

---

### Patrones implementados

### Creacionales
Gestionan el proceso de creación de objetos, desacoplando al cliente de las clases concretas.

| Patrón            | Concepto clave              | Aplicación común                          |
|-------------------|-----------------------------|-------------------------------------------|
| **Factory Method**    | Delegar instanciación       | Creación de diferentes tipos de notificaciones |
| **Abstract Factory**  | Familias de objetos         | UI Kits (Material vs Cupertino)           |
| **Builder**           | Paso a paso                 | Construcción de objetos complejos (HTTP requests) |
| **Prototype**         | Clonación                   | Duplicar modelos de datos con `copyWith`  |
| **Singleton**         | Instancia única             | Servicios de base de datos o Auth         |

### Estructurales
Gestionan la composición de clases y objetos para formar estructuras más grandes y flexibles.

| Patrón            | Concepto clave                    | Aplicación común                              |
|-------------------|-----------------------------------|-----------------------------------------------|
| **Adapter**           | Traducir interfaces               | Integrar librerías externas de terceros       |
| **Bridge**            | Abstracción vs Implementación     | Drivers de base de datos vs Lógica de negocio |
| **Composite**         | Jerarquía de árbol                | Estructura de carpetas o Widgets en Flutter   |
| **Decorator**         | Envolver funcionalidad            | Añadir logs o encriptación a servicios        |
| **Facade**            | Punto de entrada único            | Interfaz simple para un subsistema complejo   |
| **Flyweight**         | Compartir estado intrínseco       | Optimización de memoria en sistemas de partículas |
| **Proxy**             | Control de acceso                 | Caching de resultados o Lazy Loading          |

### De comportamiento
Gestionan la comunicación, algoritmos y distribución de responsabilidades.

| Patrón                  | Concepto clave                  | Aplicación común                              |
|-------------------------|---------------------------------|-----------------------------------------------|
| **Chain of Responsibility** | Cadena de mando              | Middleware de autenticación y logs            |
| **Command**             | Encapsular acciones             | Implementación de botones con Undo/Redo       |
| **Interpreter**         | Gramática y lenguaje            | Parsing de expresiones matemáticas            |
| **Iterator**            | Recorrido uniforme              | Navegar colecciones personalizadas            |
| **Mediator**            | Hub de comunicaciones           | Comunicación entre múltiples componentes UI   |
| **Memento**             | Capturar estado previo          | Guardado de estados en juegos o editores      |
| **Observer**            | Suscripción a eventos           | Streams en Dart y gestión de estados (Bloc)   |
| **State**               | Comportamiento por estado       | Ciclo de vida de una descarga o conexión      |
| **Strategy**            | Algoritmos intercambiables      | Diferentes métodos de pago o ordenamiento     |
| **Template Method**     | Esqueleto de algoritmo          | Flujo base de procesamiento de datos          |
| **Visitor**             | Operaciones externas            | Reportes o analítica sobre jerarquías         |

---

## Cómo ejecutar los ejemplos

Cada patrón es independiente y contiene su propio archivo `README.md` detallado.

```bash
# Ejemplo: Ejecutar el patrón Singleton
cd Creational/singleton
dart run main.dart
```
---
### Requisitos

Dart SDK >= 3.0.0

---
### Referencias

- Gamma, E. et al. — Design Patterns: Elements of Reusable Object-Oriented Software (GoF).
- Refactoring Guru — refactoring.guru/design-patterns
Dart Documentation — dart.dev
