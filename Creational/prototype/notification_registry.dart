import 'notification.dart';

class NotificationRegistry {
  final Map<String, Notification> _plantillas = {};

  void registrar(String clave, Notification plantilla) {
    _plantillas[clave] = plantilla;
  }

  Notification obtenerClon(String clave) {
    final plantilla = _plantillas[clave];
    if (plantilla == null) {
      throw ArgumentError('No existe una plantilla con la clave: $clave');
    }
    return plantilla.clone();
  }
}
