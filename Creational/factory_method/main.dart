import 'factory.dart';
import 'animal.dart';
void main() {
  AnimalFactory factory;

  factory = DogFactory();
  Animal animal1 = factory.createAnimal();
  animal1.speak();

  factory = CatFactory();
  Animal animal2 = factory.createAnimal();
  animal2.speak();
}