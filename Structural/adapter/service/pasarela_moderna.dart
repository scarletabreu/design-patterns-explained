import '../target/procesador_pago.dart';

class PasarelaModerna implements ProcesadorPago {
  @override
  void pagar(double monto) {
    print('Moderna: cobrando RD\$$monto');
  }
}
