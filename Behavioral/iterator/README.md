# Patrón Iterator (Iterador)

## Descripción general

El Iterator es un patrón de diseño de comportamiento que proporciona una forma de recorrer secuencialmente los elementos de una colección sin exponer su representación interna (lista, árbol, grafo, etc.). El iterador encapsula la lógica de recorrido en un objeto separado de la colección.

---

## Problema

Considera una colección de libros almacenada internamente como un arreglo. Si el cliente accede directamente al arreglo para recorrerlo, queda acoplado a la estructura interna. Cambiar la estructura (por ejemplo, a un árbol o a una lista enlazada) rompería todo el código cliente.

**Enfoque incorrecto (acceso directo a la estructura interna):**

```dart
for (int i = 0; i < bookCollection.books.length; i++) {
  print(bookCollection.books[i].title);
}
```

Este código depende de que `books` sea un `List` indexable. Si la estructura cambia, el cliente se rompe.

**Enfoque correcto usando Iterator:**

```dart
final iterator = bookCollection.createIterator();

while (iterator.hasNext()) {
  print(iterator.next().title);
}
```

El cliente no sabe nada sobre cómo está almacenada la colección; solo consume el iterador.

---

## Estructura

| Componente | Rol |
|---|---|
| Iterator | Interfaz que define `hasNext()` y `next()` |
| Concrete Iterator | Implementa el recorrido sobre una colección concreta |
| IterableCollection | Interfaz de la colección que expone `createIterator()` |
| Concrete Collection | La colección real que devuelve su iterador concreto |
| Client | Recorre la colección a través del iterador sin conocer su estructura |

---

## Implementación en Dart

**`model/book.dart`**

```dart
class Book {
  final String title;
  final String author;

  Book({required this.title, required this.author});

  @override
  String toString() => '"$title" de $author';
}
```

**`iterator/iterator.dart`**

```dart
abstract class Iterator<T> {
  bool hasNext();
  T next();
}
```

**`iterator/book_iterator.dart`**

```dart
import '../model/book.dart';
import 'iterator.dart';

class BookIterator implements Iterator<Book> {
  final List<Book> _books;
  int _index = 0;

  BookIterator(this._books);

  @override
  bool hasNext() => _index < _books.length;

  @override
  Book next() {
    if (!hasNext()) throw StateError("No hay más elementos.");
    return _books[_index++];
  }
}
```

**`collection/iterable_collection.dart`**

```dart
import '../iterator/iterator.dart';

abstract class IterableCollection<T> {
  Iterator<T> createIterator();
}
```

**`collection/book_collection.dart`**

```dart
import '../model/book.dart';
import '../iterator/book_iterator.dart';
import '../iterator/iterator.dart';
import 'iterable_collection.dart';

class BookCollection implements IterableCollection<Book> {
  final List<Book> _books = [];

  void addBook(Book book) => _books.add(book);

  @override
  Iterator<Book> createIterator() => BookIterator(List.unmodifiable(_books));
}
```

**`main.dart`**

```dart
import 'model/book.dart';
import 'collection/book_collection.dart';

void main() {
  final collection = BookCollection();
  collection.addBook(Book(title: "Clean Code", author: "Robert C. Martin"));
  collection.addBook(Book(title: "The Pragmatic Programmer", author: "Hunt & Thomas"));
  collection.addBook(Book(title: "Design Patterns", author: "Gang of Four"));

  final iterator = collection.createIterator();

  print("Recorriendo la colección:");
  while (iterator.hasNext()) {
    print("  → ${iterator.next()}");
  }
}
```

**Salida esperada:**

```text
Recorriendo la colección:
  → "Clean Code" de Robert C. Martin
  → "The Pragmatic Programmer" de Hunt & Thomas
  → "Design Patterns" de Gang of Four
```

---

## Variante avanzada: iterador en orden inverso

Es posible ofrecer múltiples estrategias de recorrido creando iteradores adicionales sin modificar la colección:

```dart
class ReverseBookIterator implements Iterator<Book> {
  final List<Book> _books;
  int _index;

  ReverseBookIterator(List<Book> books)
      : _books = books,
        _index = books.length - 1;

  @override
  bool hasNext() => _index >= 0;

  @override
  Book next() {
    if (!hasNext()) throw StateError("No hay más elementos.");
    return _books[_index--];
  }
}
```

La colección puede exponer ambos recorridos:

```dart
class BookCollection implements IterableCollection<Book> {
  // ...

  Iterator<Book> createReverseIterator() =>
      ReverseBookIterator(List.unmodifiable(_books));
}
```

Con esto, el cliente elige el tipo de recorrido sin que la colección cambie su estructura interna.

---

## Ventajas y desventajas

**Ventajas**
- Permite recorrer colecciones sin exponer su representación interna
- Soporta múltiples recorridos simultáneos sobre la misma colección
- Cumple el Principio de Responsabilidad Única: la lógica de recorrido se separa de la colección
- Facilita el intercambio de la colección subyacente sin afectar al cliente

**Desventajas**
- Puede ser innecesario si la colección ya implementa `Iterable` del lenguaje (como en Dart)
- Agrega clases adicionales para colecciones simples donde un `for` sería suficiente

---

## Cuándo utilizarlo

Aplica el patrón Iterator cuando:

- Se necesita recorrer colecciones complejas (árboles, grafos, listas enlazadas) de forma uniforme
- Se desea proporcionar distintas estrategias de recorrido sobre la misma estructura
- Se quiere ocultar los detalles de implementación de la colección al cliente
- Se necesita soporte para recorridos concurrentes independientes

---

## Aplicaciones en Flutter

- Recorrido de árboles de widgets o nodos de un menú jerárquico
- Paginación de listas de datos con lógica de carga diferida
- Navegación entre pasos de un wizard o formulario multipaso
- Recorrido de historiales de acciones o registros de auditoría

---

## Estructura del proyecto

```
iterator/
│
├── model/
│   └── book.dart
│
├── iterator/
│   ├── iterator.dart
│   └── book_iterator.dart
│
├── collection/
│   ├── iterable_collection.dart
│   └── book_collection.dart
│
├── main.dart
└── README.md
```

---

## Ejecución del ejemplo

```bash
dart run behavioral/iterator/main.dart
```