import 'tree_type.dart';

class ConcreteTreeType implements TreeType {
  final String name;
  final String color;
  final String texture;

  ConcreteTreeType(this.name, this.color, this.texture);

  @override
  void draw(int x, int y) {
    print("Dibujando $name en ($x, $y) con color $color y textura $texture");
  }
}