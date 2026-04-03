import 'factory/factory.dart';
import 'factory/dark_theme_factory.dart';

void main() {
  UIFactory factory = DarkThemeFactory();

  final button = factory.createButton();
  final input = factory.createInput();

  button.render();
  input.render();
}