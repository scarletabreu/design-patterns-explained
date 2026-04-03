import 'animal.dart';

class Dog implements Animal {
  @override
  void speak() {
    print("Woof");
  }
}