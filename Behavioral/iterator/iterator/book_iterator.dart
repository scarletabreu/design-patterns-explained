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