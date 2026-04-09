import 'manejador.dart';
import '../request/solicitud_soporte.dart';

class SoporteIngenieria extends Manejador {
  @override
  void manejar(SolicitudSoporte solicitud) {
    if (solicitud.nivel >= 3) {
      print('Ingeniería resuelve: ${solicitud.descripcion}');
    } else {
      super.manejar(solicitud);
    }
  }
}
