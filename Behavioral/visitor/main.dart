import 'element/dragon.dart';
import 'element/goblin.dart';
import 'element/monster.dart';
import 'visitor/stats_visitor.dart';

void main() {
  final List<Monster> monsters = [
    Dragon("Viserion"),
    Goblin("Dobby"),
    Dragon("Drogon"),
  ];

  final statsVisitor = StatsVisitor();

  print("--- Iniciando Inspección de Monstruos ---");
  for (var monster in monsters) {
    monster.accept(statsVisitor);
  }
}