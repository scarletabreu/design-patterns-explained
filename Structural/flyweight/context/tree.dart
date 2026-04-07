import '../flyweight/tree_type.dart';

class Tree {
  final int x;
  final int y;
  final TreeType type;

  Tree(this.x, this.y, this.type);

  void draw() {
    type.draw(x, y);
  }
}