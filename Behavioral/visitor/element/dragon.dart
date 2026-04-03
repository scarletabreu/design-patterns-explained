import '../visitor/monster_visitor.dart';
import 'monster.dart';

class Dragon extends Monster {
  int firePower = 100;
  Dragon(String name) : super(name);

  @override
  void accept(MonsterVisitor visitor) => visitor.visitDragon(this);
}