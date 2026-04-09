import 'estrategia_descuento.dart';

class DescuentoPorcentaje implements EstrategiaDescuento {
  final double porcentaje;

  DescuentoPorcentaje(this.porcentaje);

  @override
  double aplicar(double total) => total * (1 - porcentaje / 100);
}
