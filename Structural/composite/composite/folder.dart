import '../component/file_system_component.dart';

class Folder extends FileSystemComponent {
  final List<FileSystemComponent> _children = [];

  Folder(String name) : super(name);

  void add(FileSystemComponent component) {
    _children.add(component);
  }

  @override
  void ls() {
    print("Carpeta: [$name]");
    for (var child in _children) {
      child.ls();
    }
  }

  @override
  int getSize() {
    return _children.fold(0, (sum, child) => sum + child.getSize());
  }
}