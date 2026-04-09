import 'estacion_meteorologica.dart';
import 'pantalla_celsius.dart';
import 'alerta_calor.dart';

void main() {
  final estacion = EstacionMeteorologica();
  estacion.suscribir(PantallaCelsius());
  estacion.suscribir(AlertaCalor());

  estacion.nuevaLectura(28.4);
  estacion.nuevaLectura(36.7);
}
