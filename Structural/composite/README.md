# Patrón Composite

## Descripción general

El Composite es un patrón de diseño estructural que permite tratar objetos individuales y colecciones de objetos de manera uniforme, a través de una interfaz común.

El cliente no necesita distinguir si está operando sobre un elemento único o sobre un grupo completo: la misma llamada funciona en ambos casos.

---

## Problema

Considera el sistema de archivos de un ordenador: existen archivos individuales y carpetas que pueden contener archivos u otras carpetas. Si se quiere calcular el tamaño total de un directorio, la lógica debe recorrer recursivamente toda la jerarquía.

**Sin el patrón (distinción manual en el cliente):**

```dart
if (item is File) {
  print(item.getSize());
} else if (item is Folder) {
  // recorrer hijos manualmente...
}
```

**Con el patrón Composite:**

```dart
item.getSize(); // funciona igual para File y Folder
```

El cliente delega la lógica recursiva al propio árbol de objetos.

---

## Estructura

| Componente | Rol |
|---|---|
| Component | Interfaz común para hojas y compuestos (`FileSystemComponent`) |
| Leaf | Objeto individual sin hijos (`File`) |
| Composite | Objeto que contiene otros componentes (`Folder`) |

---

## Implementación en Dart

**`component/file_system_component.dart`**

```dart
abstract class FileSystemComponent {
  String name;
  FileSystemComponent(this.name);

  void ls();
  int getSize();
}
```

**`leaf/file.dart`**

```dart
import '../component/file_system_component.dart';

class File extends FileSystemComponent {
  int size;

  File(String name, this.size) : super(name);

  @override
  void ls() => print("  Archivo: $name ($size KB)");

  @override
  int getSize() => size;
}
```

**`composite/folder.dart`**

```dart
import '../component/file_system_component.dart';

class Folder extends FileSystemComponent {
  final List<FileSystemComponent> _children = [];

  Folder(String name) : super(name);

  void add(FileSystemComponent component) {
    _children.add(component);
  }

  @override
  void ls() {
    print("Carpeta: [$name]");
    for (var child in _children) {
      child.ls();
    }
  }

  @override
  int getSize() {
    return _children.fold(0, (sum, child) => sum + child.getSize());
  }
}
```

**`main.dart`**

```dart
import 'composite/folder.dart';
import 'leaf/file.dart';

void main() {
  final file1 = File("foto_pucmm.jpg", 1500);
  final file2 = File("tarea_haskell.hs", 10);
  final file3 = File("resumen_patterns.pdf", 500);

  final uniFolder = Folder("Universidad");
  uniFolder.add(file2);
  uniFolder.add(file3);

  final root = Folder("Escritorio");
  root.add(file1);
  root.add(uniFolder);

  root.ls();
  print("Tamaño total: ${root.getSize()} KB");
}
```

**Salida esperada:**

```text
Carpeta: [Escritorio]
  Archivo: foto_pucmm.jpg (1500 KB)
Carpeta: [Universidad]
  Archivo: tarea_haskell.hs (10 KB)
  Archivo: resumen_patterns.pdf (500 KB)
Tamaño total: 2010 KB
```

---

## Ventajas y desventajas

**Ventajas**
- El cliente opera sobre toda la jerarquía sin conocer su estructura interna
- Facilita la incorporación de nuevos tipos de componentes sin modificar el código existente
- Modela de forma natural cualquier estructura con forma de árbol
- Sigue el Principio Abierto/Cerrado

**Desventajas**
- Puede resultar difícil restringir qué tipos de componentes pueden formar parte de un compuesto
- La interfaz común puede volverse demasiado genérica si los componentes son muy distintos entre sí

---

## Cuándo utilizarlo

Aplica el patrón Composite cuando:

- La estructura de los datos es jerárquica o tiene forma de árbol
- Se requiere que el cliente trate de forma uniforme elementos simples y compuestos
- Las operaciones deben propagarse recursivamente por toda la jerarquía

---

## Aplicaciones en Flutter

- Árbol de widgets (cada widget puede contener otros widgets)
- Sistemas de menús con submenús anidados
- Estructuras de datos jerárquicas como organigramas o categorías de productos

---

## Estructura del proyecto

```
composite/
│
├── component/
│   └── file_system_component.dart
│
├── leaf/
│   └── file.dart
│
├── composite/
│   └── folder.dart
│
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart structural/composite/main.dart
```