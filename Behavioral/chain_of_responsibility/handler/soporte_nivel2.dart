import 'manejador.dart';
import '../request/solicitud_soporte.dart';

class SoporteNivel2 extends Manejador {
  @override
  void manejar(SolicitudSoporte solicitud) {
    if (solicitud.nivel == 2) {
      print('Nivel 2 resuelve: ${solicitud.descripcion}');
    } else {
      super.manejar(solicitud);
    }
  }
}
