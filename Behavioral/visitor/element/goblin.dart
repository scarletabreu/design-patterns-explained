import '../visitor/monster_visitor.dart';
import 'monster.dart';

class Goblin extends Monster {
  int stealth = 50;
  Goblin(String name) : super(name);

  @override
  void accept(MonsterVisitor visitor) => visitor.visitGoblin(this);
}