import 'concrete_tree_type.dart';

class TreeFactory {
  static final Map<String, ConcreteTreeType> _treeTypes = {};

  static ConcreteTreeType getTreeType(String name, String color, String texture) {
    final key = "$name-$color-$texture";

    if (!_treeTypes.containsKey(key)) {
      _treeTypes[key] = ConcreteTreeType(name, color, texture);
    }

    return _treeTypes[key]!;
  }
}