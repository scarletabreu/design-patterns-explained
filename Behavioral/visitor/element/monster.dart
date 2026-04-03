import '../visitor/monster_visitor.dart';

abstract class Monster {
  String name;
  Monster(this.name);

  void accept(MonsterVisitor visitor);
}