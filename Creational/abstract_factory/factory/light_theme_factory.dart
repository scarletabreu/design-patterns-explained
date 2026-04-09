import 'factory.dart'; 
import '../theme/light_theme.dart';
import '../widgets/button.dart';
import '../widgets/input.dart';

class LightThemeFactory implements UIFactory {
  @override
  Button createButton() => LightButton();

  @override
  Input createInput() => LightInput();
}