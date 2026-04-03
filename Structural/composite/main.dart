import 'composite/folder.dart';
import 'leaf/file.dart';

void main() {
  final file1 = File("foto_pucmm.jpg", 1500);
  final file2 = File("tarea_haskell.hs", 10);
  final file3 = File("resumen_patterns.pdf", 500);

  final root = Folder("Escritorio");
  final uniFolder = Folder("Universidad");

  uniFolder.add(file2);
  uniFolder.add(file3);

  root.add(file1);
  root.add(uniFolder);

  print("--- Estructura de archivos ---");
  root.ls();
  
  print("\nTamaño total del Escritorio: ${root.getSize()} KB");
}