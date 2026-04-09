import 'target/procesador_pago.dart';
import 'service/pasarela_moderna.dart';
import 'adapter/adaptador_legacy.dart';
import 'adaptee/pasarela_legacy.dart';

void main() {
  final List<ProcesadorPago> procesadores = [
    PasarelaModerna(),
    AdaptadorLegacy(PasarelaLegacy()),
  ];

  for (final p in procesadores) {
    p.pagar(1500.50);
  }
}
