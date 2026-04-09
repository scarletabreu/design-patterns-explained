import '../iterator/iterator.dart';

abstract class IterableCollection<T> {
  Iterator<T> createIterator();
}