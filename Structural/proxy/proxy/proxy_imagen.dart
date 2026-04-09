import '../subject/servicio_imagenes.dart';
import '../real_subject/imagen_real.dart';

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
