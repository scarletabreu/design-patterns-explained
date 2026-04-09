import 'editor_memento.dart';

class Historial {
  final List<EditorMemento> _estados = [];

  void push(EditorMemento memento) => _estados.add(memento);

  EditorMemento? pop() => _estados.isEmpty ? null : _estados.removeLast();
}
