import '../component/coffee.dart';

class SimpleCoffee implements Coffee {
  @override
  String getDescription() => "Café Negro";

  @override
  double getCost() => 50.0;
}