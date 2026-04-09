import 'manejador.dart';
import 'solicitud_soporte.dart';

class SoporteNivel1 extends Manejador {
  @override
  void manejar(SolicitudSoporte solicitud) {
    if (solicitud.nivel <= 1) {
      print('Nivel 1 resuelve: ${solicitud.descripcion}');
    } else {
      super.manejar(solicitud);
    }
  }
}
