import 'subject/estacion_meteorologica.dart';
import 'observer/pantalla_celsius.dart';
import 'observer/alerta_calor.dart';

void main() {
  final estacion = EstacionMeteorologica();
  estacion.suscribir(PantallaCelsius());
  estacion.suscribir(AlertaCalor());

  estacion.nuevaLectura(28.4);
  estacion.nuevaLectura(36.7);
}
