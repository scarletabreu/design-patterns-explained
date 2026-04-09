import '../widgets/button.dart';
import '../widgets/input.dart';

class LightButton implements Button {
  @override
  void render() {
    print("Light Button");
  }
}

class LightInput implements Input {
  @override
  void render() {
    print("Light Input");
  }
}