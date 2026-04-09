import 'expression.dart';

class TerminalExpression implements Expression {
  final String _variable;

  TerminalExpression(this._variable);

  @override
  bool interpret(Map<String, bool> context) {
    return context[_variable] ?? false;
  }
}