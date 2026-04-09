import 'solicitud_soporte.dart';
import 'soporte_nivel1.dart';
import 'soporte_nivel2.dart';
import 'soporte_ingenieria.dart';

void main() {
  final n1 = SoporteNivel1();
  n1.encadenar(SoporteNivel2()).encadenar(SoporteIngenieria());

  n1.manejar(SolicitudSoporte('Olvidé mi contraseña', 1));
  n1.manejar(SolicitudSoporte('Error en facturación', 2));
  n1.manejar(SolicitudSoporte('Caída del servidor', 3));
}
