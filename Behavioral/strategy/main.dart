import 'carrito.dart';
import 'sin_descuento.dart';
import 'descuento_porcentaje.dart';
import 'descuento_fijo.dart';

void main() {
  final carrito = Carrito(SinDescuento())
    ..agregar(500)
    ..agregar(1200)
    ..agregar(300);

  print('Sin descuento: RD\$${carrito.total()}');

  carrito.estrategia = DescuentoPorcentaje(15);
  print('15% off: RD\$${carrito.total()}');

  carrito.estrategia = DescuentoFijo(250);
  print('RD\$250 off: RD\$${carrito.total()}');
}
