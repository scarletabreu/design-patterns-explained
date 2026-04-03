import 'animal.dart';
import 'dog.dart';
import 'cat.dart';


abstract class AnimalFactory {
  Animal createAnimal();
}
class DogFactory implements AnimalFactory {
  @override
  Animal createAnimal() {
    return Dog();
  }
}

class CatFactory implements AnimalFactory {
  @override
  Animal createAnimal() {
    return Cat();
  }
}