import '../component/coffee.dart';

abstract class CoffeeDecorator implements Coffee {
  final Coffee _decoratedCoffee;

  CoffeeDecorator(this._decoratedCoffee);

  @override
  String getDescription() => _decoratedCoffee.getDescription();

  @override
  double getCost() => _decoratedCoffee.getCost();
}