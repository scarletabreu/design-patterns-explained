import 'component.dart';

class InputField extends Component {
  final String name;
  String value = "";

  InputField(this.name);

  void setValue(String val) {
    value = val;
    print("$name: valor actualizado → '$value'");
    mediator.notify(this, "changed");
  }

  bool get isValid => value.trim().isNotEmpty;
}