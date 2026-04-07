import 'notification.dart';
import 'notification_registry.dart';

void main() {
  // Crear plantillas base (prototipos)
  final plantillaEmail = Notification(
    tipo: 'email',
    titulo: 'Bienvenido a nuestra plataforma',
    mensaje: 'Gracias por registrarte. Tu cuenta ha sido creada exitosamente.',
    destinatario: '',
    metadatos: {'prioridad': 'normal', 'categoria': 'onboarding'},
  );

  final plantillaPush = Notification(
    tipo: 'push',
    titulo: '¡Tienes una nueva oferta!',
    mensaje: 'Aprovecha un 20% de descuento en tu próxima compra.',
    destinatario: '',
    metadatos: {'prioridad': 'alta', 'categoria': 'marketing'},
  );

  // Registrar prototipos en el registro
  final registro = NotificationRegistry();
  registro.registrar('bienvenida', plantillaEmail);
  registro.registrar('oferta', plantillaPush);

  // Clonar y personalizar para distintos usuarios
  final notifUsuario1 = registro.obtenerClon('bienvenida');
  notifUsuario1.destinatario = 'usuario1@ejemplo.com';

  final notifUsuario2 = registro.obtenerClon('bienvenida');
  notifUsuario2.destinatario = 'usuario2@ejemplo.com';
  notifUsuario2.metadatos['idioma'] = 'en';

  final ofertaUsuario1 = registro.obtenerClon('oferta');
  ofertaUsuario1.destinatario = 'usuario1@ejemplo.com';
  ofertaUsuario1.mensaje = 'Aprovecha un 30% de descuento exclusivo para ti.';

  // Verificar que los clones son independientes del original
  print('=== Plantilla original ===');
  print(plantillaEmail);
  print('');
  print('=== Clones personalizados ===');
  print(notifUsuario1);
  print(notifUsuario2);
  print(ofertaUsuario1);
}
