import 'observador.dart';

class Sujeto<T> {
  final List<Observador<T>> _observadores = [];

  void suscribir(Observador<T> observador) {
    _observadores.add(observador);
  }

  void desuscribir(Observador<T> observador) {
    _observadores.remove(observador);
  }

  void notificar(T dato) {
    for (final o in _observadores) {
      o.actualizar(dato);
    }
  }
}
