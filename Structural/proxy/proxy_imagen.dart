import 'servicio_imagenes.dart';
import 'imagen_real.dart';

class ProxyImagen implements ServicioImagenes {
  final String ruta;
  ImagenReal? _imagen;

  ProxyImagen(this.ruta);

  @override
  void mostrar() {
    _imagen ??= ImagenReal(ruta);
    _imagen!.mostrar();
  }
}
