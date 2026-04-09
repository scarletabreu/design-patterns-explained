# Patrón Singleton

## Descripción general

El **Singleton** es un patrón de diseño creacional que garantiza que una clase tenga **una única instancia** en toda la aplicación y proporciona un punto de acceso global a ella.

Es ideal para gestionar recursos compartidos como conexiones a bases de datos, servicios de autenticación o configuraciones globales.

## Problema

Imagina que estás gestionando la conexión a una base de datos en una aplicación de Flutter. Si cada widget o servicio crea una nueva instancia del conector, podrías terminar con decenas de conexiones abiertas innecesariamente, consumiendo memoria y saturando el servidor.

### Enfoque sin Singleton (problemático):

```dart
// Cada vez que necesitas la DB, creas una instancia nueva
final db1 = DatabaseService(); 
final db2 = DatabaseService(); 

print(identical(db1, db2)); // false (son objetos distintos)
```

Esto causa inconsistencia en los datos y un uso ineficiente de los recursos.

### Enfoque con Singleton (Dart style):

```dart
// No importa cuántas veces lo llames, siempre es el mismo objeto
final db1 = DatabaseService();
final db2 = DatabaseService();

print(identical(db1, db2)); // true (es la misma instancia)
```

## Estructura

| Componente              | Rol |
|-------------------------|-----|
| Instancia Privada       | Almacena la única instancia de la clase (`_instance`) |
| Constructor Privado     | Evita que se creen instancias desde fuera de la clase (`_internal`) |
| Constructor Factory     | Lógica que decide si devolver la instancia existente o crear una nueva |

## Implementación en Dart

### 1. La Clase Singleton

```dart
class DatabaseService {
  // 1. Instancia estática privada
  static final DatabaseService _instance = DatabaseService._internal();

  String connectionString = "postgres://localhost:5432/my_db";

  // 2. Constructor privado (named constructor)
  DatabaseService._internal() {
    print("Inicializando conexión única...");
  }

  // 3. Constructor factory
  // En Dart, el factory permite devolver una instancia ya creada
  factory DatabaseService() {
    return _instance;
  }

  void connect() {
    print("Conectado exitosamente a $connectionString");
  }
}
```

> **Nota:** A diferencia de Java o C#, en Dart no necesitas llamar a un método `getInstance()`. Al usar `factory`, el desarrollador simplemente usa el constructor estándar `DatabaseService()`, lo que hace que el código sea más limpio.

### 2. Uso

```dart
void main() {
  // Ambas variables apuntan al mismo espacio de memoria
  final serviceA = DatabaseService();
  final serviceB = DatabaseService();

  serviceA.connect();
  
  if (identical(serviceA, serviceB)) {
    print("Singleton funciona: Ambas variables comparten la misma instancia.");
  }
}
```

## Ventajas y desventajas

### Ventajas

- Control estricto sobre el acceso a la instancia única
- Ahorro de recursos (memoria y CPU)
- Se inicializa solo cuando se necesita por primera vez (**Lazy initialization**)
- Evita conflictos de estado global al centralizar la lógica

### Desventajas

- Puede dificultar las pruebas unitarias (Testing) al introducir un estado global
- Viola el Principio de Responsabilidad Única (la clase controla su propio ciclo de vida)
- Si se abusa de él, puede ocultar dependencias mal diseñadas en el código

## Cuándo utilizarlo

Aplica el patrón **Singleton** cuando:

- Necesites un acceso único a un recurso físico (impresoras, sensores, bases de datos)
- Gestiones configuraciones globales que no deben variar en diferentes partes de la app
- Tengas un servicio de autenticación que debe persistir en toda la sesión
- El costo de crear el objeto sea muy elevado y deba reutilizarse

## Aplicaciones en Flutter

- **Servicios de API**: Una sola instancia de Dio o Http con la configuración base.
- **LocalStorage**: Instancia única para gestionar SharedPreferences o Hive.
- **Firebase**: El SDK de Firebase en Flutter utiliza singletons para acceder a Auth o Firestore.
- **Theme Management**: Controlar el cambio de tema (dark/light mode) de forma centralizada.

## Estructura del proyecto

```
singleton/
│
├── database_service.dart
├── main.dart
└── README.md
```

## Ejecución del ejemplo

```bash
dart Creational/singleton/main.dart
```