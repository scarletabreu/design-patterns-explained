import 'builder/concrete_house_builder.dart';
import 'product/house.dart';

void main() {
  final builder = ConcreteHouseBuilder();

  print("Construyendo Mansión...");
  builder.setWindows(12);
  builder.setDoors(4);
  builder.setWallColor("Beige");
  builder.addGarage();
  builder.addPool();
  House mansion = builder.getResult();
  mansion.showDetails();

  print("Construyendo Casa Minimalista...");
  builder.setWindows(2);
  builder.setDoors(1);
  builder.setWallColor("Gris");
  House simpleHouse = builder.getResult();
  simpleHouse.showDetails();
}