import 'flyweight/tree_factory.dart';
import 'context/tree.dart';

void main() {
  final trees = <Tree>[];

  final pineType = TreeFactory.getTreeType("Pino", "Verde", "Rugosa");
  final oakType = TreeFactory.getTreeType("Roble", "Oscuro", "Lisa");

  trees.add(Tree(10, 20, pineType));
  trees.add(Tree(30, 40, pineType));
  trees.add(Tree(50, 60, oakType));

  for (var tree in trees) {
    tree.draw();
  }
}