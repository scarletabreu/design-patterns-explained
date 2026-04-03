import 'coffee_decorator.dart';

class SugarDecorator extends CoffeeDecorator {
  SugarDecorator(super.coffee);

  @override
  String getDescription() => "${super.getDescription()}, con Azúcar";

  @override
  double getCost() => super.getCost() + 5.0;
}