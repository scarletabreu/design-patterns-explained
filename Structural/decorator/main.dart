import 'component/coffee.dart';
import 'concrete_component/simple_coffee.dart';
import 'decorator/milk_decorator.dart';
import 'decorator/sugar_decorator.dart';

void main() {
  Coffee myCoffee = SimpleCoffee(); 
  print("${myCoffee.getDescription()} -> \$${myCoffee.getCost()}");

  myCoffee = MilkDecorator(myCoffee); 
  print("${myCoffee.getDescription()} -> \$${myCoffee.getCost()}");

  myCoffee = SugarDecorator(myCoffee); 
  print("${myCoffee.getDescription()} -> \$${myCoffee.getCost()}");
}