import 'expression.dart';

class NotExpression implements Expression {
  final Expression _operand;

  NotExpression(this._operand);

  @override
  bool interpret(Map<String, bool> context) {
    return !_operand.interpret(context);
  }
}