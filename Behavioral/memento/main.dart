import 'originator/editor.dart';
import 'caretaker/historial.dart';

void main() {
  final editor = Editor();
  final historial = Historial();

  editor.escribir('Hola');
  historial.push(editor.guardar());

  editor.escribir(', mundo');
  historial.push(editor.guardar());

  editor.escribir('!');
  print(editor.contenido);

  editor.restaurar(historial.pop()!);
  print(editor.contenido);

  editor.restaurar(historial.pop()!);
  print(editor.contenido);
}
