import '../target/procesador_pago.dart';
import '../adaptee/pasarela_legacy.dart';

class AdaptadorLegacy implements ProcesadorPago {
  final PasarelaLegacy _legacy;

  AdaptadorLegacy(this._legacy);

  @override
  void pagar(double monto) {
    final centavos = (monto * 100).round();
    _legacy.realizarCobro(centavos, 'DOP');
  }
}
