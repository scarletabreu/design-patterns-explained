import 'solicitud_soporte.dart';

abstract class Manejador {
  Manejador? _siguiente;

  Manejador encadenar(Manejador siguiente) {
    _siguiente = siguiente;
    return siguiente;
  }

  void manejar(SolicitudSoporte solicitud) {
    if (_siguiente != null) {
      _siguiente!.manejar(solicitud);
    } else {
      print('Solicitud sin resolver: ${solicitud.descripcion}');
    }
  }
}
