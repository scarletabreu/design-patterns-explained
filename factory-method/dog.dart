import 'animal.dart';

class Dog implements Animal {
  @override
  void speak() {
    print("Woof");
  }
}

class Cat implements Animal {
  @override
  void speak() {
    print("Meow");
  }
}