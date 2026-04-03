import '../component/file_system_component.dart';

class File extends FileSystemComponent {
  int size;

  File(String name, this.size) : super(name);

  @override
  void ls() {
    print("  Archivo: $name ($size KB)");
  }

  @override
  int getSize() => size;
}