import 'observador.dart';

class AlertaCalor implements Observador<double> {
  @override
  void actualizar(double dato) {
    if (dato > 35) print('¡Alerta de calor extremo!');
  }
}
