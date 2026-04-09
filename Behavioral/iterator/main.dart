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