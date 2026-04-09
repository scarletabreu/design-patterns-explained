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