import '../element/dragon.dart';
import '../element/goblin.dart';
import 'monster_visitor.dart';

class StatsVisitor implements MonsterVisitor {
  @override
  void visitDragon(Dragon dragon) {
    print("Analizando Dragón ${dragon.name}: Poder de fuego es ${dragon.firePower}.");
  }

  @override
  void visitGoblin(Goblin goblin) {
    print("Analizando Goblin ${goblin.name}: Sigilo es ${goblin.stealth}.");
  }
}