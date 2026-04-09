import '../receiver/text_editor.dart';
import 'command.dart';

class WriteCommand implements Command {
  final TextEditor _editor;
  final String _text;

  WriteCommand(this._editor, this._text);

  @override
  void execute() => _editor.write(_text);

  @override
  void undo() => _editor.erase(_text.length);
}