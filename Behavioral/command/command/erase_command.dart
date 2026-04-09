import '../receiver/text_editor.dart';
import 'command.dart';

class EraseCommand implements Command {
  final TextEditor _editor;
  final int _charCount;
  String _erasedText = "";

  EraseCommand(this._editor, this._charCount);

  @override
  void execute() {
    final content = _editor.content;
    final start = (content.length - _charCount).clamp(0, content.length);
    _erasedText = content.substring(start);
    _editor.erase(_charCount);
  }

  @override
  void undo() => _editor.write(_erasedText);
}