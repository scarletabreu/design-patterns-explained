import '../widgets/button.dart';
import '../widgets/input.dart';

abstract class UIFactory {
  Button createButton();
  Input createInput();
}