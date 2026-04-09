import 'component.dart';

class SubmitButton extends Component {
  bool enabled = false;

  void updateState(bool isEnabled) {
    enabled = isEnabled;
    print("Botón de envío: ${enabled ? 'habilitado' : 'deshabilitado'}");
  }

  void click() {
    if (!enabled) {
      print("Botón deshabilitado. Completa el formulario.");
      return;
    }
    mediator.notify(this, "clicked");
  }
}