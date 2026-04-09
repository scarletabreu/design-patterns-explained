import '../strategy/estrategia_descuento.dart';

class Carrito {
  final List<double> _items = [];
  EstrategiaDescuento estrategia;

  Carrito(this.estrategia);

  void agregar(double precio) => _items.add(precio);

  double total() {
    final subtotal = _items.fold(0.0, (a, b) => a + b);
    return estrategia.aplicar(subtotal);
  }
}
