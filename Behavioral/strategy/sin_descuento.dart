import 'estrategia_descuento.dart';

class SinDescuento implements EstrategiaDescuento {
  @override
  double aplicar(double total) => total;
}
