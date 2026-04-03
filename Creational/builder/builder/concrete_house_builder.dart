import '../product/house.dart';
import 'house_builder.dart';

class ConcreteHouseBuilder implements HouseBuilder {
  late House _house;

  ConcreteHouseBuilder() {
    reset();
  }

  @override
  void reset() {
    _house = House();
  }

  @override
  void setWindows(int count) {
    _house.windows = count;
  }

  @override
  void setDoors(int count) {
    _house.doors = count;
  }

  @override
  void setWallColor(String color) {
    _house.wallColor = color;
  }

  @override
  void addGarage() {
    _house.hasGarage = true;
  }

  @override
  void addPool() {
    _house.hasSwimmingPool = true;
  }

  @override
  House getResult() {
    House product = _house;
    reset();
    return product;
  }
}