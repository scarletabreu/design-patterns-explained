import 'estrategia_descuento.dart';

class DescuentoFijo implements EstrategiaDescuento {
  final double monto;

  DescuentoFijo(this.monto);

  @override
  double aplicar(double total) => (total - monto).clamp(0, double.infinity);
}
