import '../widgets/button.dart';
import '../widgets/input.dart';

class DarkButton implements Button {
  @override
  void render() {
    print("Dark Button");
  }
}

class DarkInput implements Input {
  @override
  void render() {
    print("Dark Input");
  }
}
