import 'servicio_imagenes.dart';

class ImagenReal implements ServicioImagenes {
  final String ruta;

  ImagenReal(this.ruta) {
    _cargarDesdeDisco();
  }

  void _cargarDesdeDisco() {
    print('Cargando $ruta desde disco...');
  }

  @override
  void mostrar() {
    print('Mostrando $ruta');
  }
}
