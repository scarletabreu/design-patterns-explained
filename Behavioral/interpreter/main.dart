import 'expression/terminal_expression.dart';
import 'expression/and_expression.dart';
import 'expression/or_expression.dart';
import 'expression/not_expression.dart';

void main() {
  final context = {
    "activo": true,
    "admin": false,
    "soporte": true,
  };

  // Expresión: activo AND (admin OR soporte)
  final expr1 = AndExpression(
    TerminalExpression("activo"),
    OrExpression(
      TerminalExpression("admin"),
      TerminalExpression("soporte"),
    ),
  );

  // Expresión: NOT admin
  final expr2 = NotExpression(TerminalExpression("admin"));

  // Expresión: activo AND NOT admin
  final expr3 = AndExpression(
    TerminalExpression("activo"),
    NotExpression(TerminalExpression("admin")),
  );

  print("activo AND (admin OR soporte): ${expr1.interpret(context)}");
  print("NOT admin: ${expr2.interpret(context)}");
  print("activo AND NOT admin: ${expr3.interpret(context)}");
}