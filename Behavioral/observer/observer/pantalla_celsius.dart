import 'observador.dart';

class PantallaCelsius implements Observador<double> {
  @override
  void actualizar(double dato) {
    print('Pantalla: ${dato.toStringAsFixed(1)} °C');
  }
}
