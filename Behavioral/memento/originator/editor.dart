import '../memento/editor_memento.dart';

class Editor {
  String _contenido = '';

  void escribir(String texto) {
    _contenido += texto;
  }

  String get contenido => _contenido;

  EditorMemento guardar() => EditorMemento(_contenido);

  void restaurar(EditorMemento memento) {
    _contenido = memento.contenido;
  }
}
