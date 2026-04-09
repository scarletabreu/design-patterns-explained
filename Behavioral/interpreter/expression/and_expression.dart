import 'expression.dart';

class AndExpression implements Expression {
  final Expression _left;
  final Expression _right;

  AndExpression(this._left, this._right);

  @override
  bool interpret(Map<String, bool> context) {
    return _left.interpret(context) && _right.interpret(context);
  }
}