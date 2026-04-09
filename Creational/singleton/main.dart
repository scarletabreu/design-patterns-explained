import 'src/database_service.dart';
void main() {
  var s1 = DatabaseService();
  var s2 = DatabaseService();

  s1.connect();

  if (identical(s1, s2)) {
    print("Éxito: s1 y s2 son la misma instancia.");
  }
}