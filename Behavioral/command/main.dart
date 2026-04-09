import 'receiver/text_editor.dart';
import 'command/write_command.dart';
import 'command/erase_command.dart';
import 'invoker/command_history.dart';

void main() {
  final editor = TextEditor();
  final history = CommandHistory();

  history.executeCommand(WriteCommand(editor, "Hola"));
  history.executeCommand(WriteCommand(editor, " Mundo"));
  history.executeCommand(EraseCommand(editor, 5));

  print("\n--- Deshaciendo operaciones ---");
  history.undoLast();
  history.undoLast();
}