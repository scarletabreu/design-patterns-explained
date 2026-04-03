import 'factory.dart'; 
import '../theme/dark_theme.dart';
import '../widgets/button.dart';
import '../widgets/input.dart';

class DarkThemeFactory implements UIFactory {
  @override
  Button createButton() => DarkButton();

  @override
  Input createInput() => DarkInput();
}