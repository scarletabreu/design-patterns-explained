class TextEditor {
  String _content = "";

  String get content => _content;

  void write(String text) {
    _content += text;
    print("Editor: contenido actual → '$_content'");
  }

  void erase(int charCount) {
    if (charCount > _content.length) charCount = _content.length;
    _content = _content.substring(0, _content.length - charCount);
    print("Editor: contenido actual → '$_content'");
  }
}