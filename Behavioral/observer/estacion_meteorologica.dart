import 'sujeto.dart';

class EstacionMeteorologica extends Sujeto<double> {
  double _temperatura = 0;

  void nuevaLectura(double temperatura) {
    _temperatura = temperatura;
    notificar(_temperatura);
  }
}
