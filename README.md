# Design Patterns Explained

Repositorio de referencia práctica para aprender y aplicar patrones de diseño de software usando Dart. Cada patrón está implementado con un ejemplo limpio y real, organizado siguiendo principios SOLID.

---

## Estructura del repositorio

```
design-patterns-explained/
│
├── Creational/
│   ├── factory-method/
│   ├── abstract-factory/
│   └── builder/
│
├── Structural/
│   ├── bridge/
│   ├── composite/
│   └── decorator/
│
└── Behavioral/
    └── visitor/
```

---

## Patrones implementados

### Creacionales

Patrones que gestionan el proceso de creación de objetos, desacoplando al cliente de las clases concretas que instancia.

| Patrón | Intención | Concepto clave |
|---|---|---|
| [Factory Method](./Creational/factory-method/) | Definir una interfaz para crear objetos, dejando que las subclases decidan qué clase instanciar | Delega la instanciación a las subclases |
| [Abstract Factory](./Creational/abstract-factory/) | Proveer una interfaz para crear familias de objetos relacionados sin especificar sus clases concretas | Garantiza consistencia entre familias de objetos |
| [Builder](./Creational/builder/) | Separar la construcción de un objeto complejo de su representación final | Ensamblado paso a paso |

---

### Estructurales

Patrones que gestionan la composición de clases y objetos para formar estructuras más grandes y flexibles.

| Patrón | Intención | Concepto clave |
|---|---|---|
| [Bridge](./Structural/bridge/) | Desacoplar una abstracción de su implementación para que ambas puedan variar de forma independiente | Composición sobre herencia en dos dimensiones |
| [Composite](./Structural/composite/) | Componer objetos en estructuras de árbol y tratar elementos individuales y compuestos de forma uniforme | Estructuras jerárquicas recursivas |
| [Decorator](./Structural/decorator/) | Añadir responsabilidades a un objeto de forma dinámica sin modificar su clase | Capas de funcionalidad en tiempo de ejecución |

---

### De comportamiento

Patrones que gestionan la comunicación y distribución de responsabilidades entre objetos.

| Patrón | Intención | Concepto clave |
|---|---|---|
| [Visitor](./Behavioral/visitor/) | Definir nuevas operaciones sobre los elementos de una estructura sin modificar sus clases | Double dispatch — separa datos de algoritmos |

---

## Cómo ejecutar los ejemplos

Cada patrón es independiente. Para ejecutar cualquier ejemplo:

```bash
cd Creational/factory-method
dart run main.dart
```

---

## Requisitos

- [Dart SDK](https://dart.dev/get-dart) >= 3.0.0

---

## Referencia rápida

| Patrón | Categoría | Problema que resuelve |
|---|---|---|
| Factory Method | Creacional | Acoplamiento a clases concretas |
| Abstract Factory | Creacional | Familias de objetos inconsistentes |
| Builder | Creacional | Constructores con demasiados parámetros |
| Bridge | Estructural | Explosión de clases por múltiples dimensiones |
| Composite | Estructural | Tratamiento inconsistente de árboles y hojas |
| Decorator | Estructural | Explosión de clases por comportamientos combinables |
| Visitor | Comportamiento | Añadir operaciones sin modificar clases existentes |

---

## Referencias

- Gamma, E. et al. — *Design Patterns: Elements of Reusable Object-Oriented Software* (GoF)
- [refactoring.guru/design-patterns](https://refactoring.guru/design-patterns)
- [dart.dev](https://dart.dev)