import 'component.dart';

class Checkbox extends Component {
  final String name;
  bool checked = false;

  Checkbox(this.name);

  void toggle() {
    checked = !checked;
    print("$name: ${checked ? 'marcado' : 'desmarcado'}");
    mediator.notify(this, "toggled");
  }
}