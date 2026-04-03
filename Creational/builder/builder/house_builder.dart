import '../product/house.dart';

abstract class HouseBuilder {
  void reset();
  void setWindows(int count);
  void setDoors(int count);
  void setWallColor(String color);
  void addGarage();
  void addPool();
  House getResult();
}