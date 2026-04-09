import 'proxy/proxy_imagen.dart';

void main() {
  final imagen = ProxyImagen('retrato.png');
  print('Proxy creado, aún sin cargar.');

  imagen.mostrar();
  imagen.mostrar();
}
