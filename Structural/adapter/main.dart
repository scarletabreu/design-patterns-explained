import 'procesador_pago.dart';
import 'pasarela_moderna.dart';
import 'adaptador_legacy.dart';
import 'pasarela_legacy.dart';

void main() {
  final List<ProcesadorPago> procesadores = [
    PasarelaModerna(),
    AdaptadorLegacy(PasarelaLegacy()),
  ];

  for (final p in procesadores) {
    p.pagar(1500.50);
  }
}
