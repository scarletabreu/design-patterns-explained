import 'coffee_decorator.dart';

class MilkDecorator extends CoffeeDecorator {
  MilkDecorator(super.coffee);

  @override
  String getDescription() => "${super.getDescription()}, con Leche";

  @override
  double getCost() => super.getCost() + 15.0;
}