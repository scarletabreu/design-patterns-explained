import '../command/command.dart';

class CommandHistory {
  final List<Command> _history = [];

  void executeCommand(Command command) {
    command.execute();
    _history.add(command);
  }

  void undoLast() {
    if (_history.isEmpty) {
      print("No hay comandos que deshacer.");
      return;
    }
    final last = _history.removeLast();
    last.undo();
  }
}