import '../element/dragon.dart';
import '../element/goblin.dart';

abstract class MonsterVisitor {
  void visitDragon(Dragon dragon);
  void visitGoblin(Goblin goblin);
}