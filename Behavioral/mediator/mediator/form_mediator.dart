import 'mediator.dart';
import '../component/input_field.dart';
import '../component/checkbox.dart';
import '../component/submit_button.dart';

class FormMediator implements Mediator {
  final InputField nameField;
  final InputField emailField;
  final Checkbox termsCheckbox;
  final SubmitButton submitButton;

  FormMediator({
    required this.nameField,
    required this.emailField,
    required this.termsCheckbox,
    required this.submitButton,
  }) {
    nameField.setMediator(this);
    emailField.setMediator(this);
    termsCheckbox.setMediator(this);
    submitButton.setMediator(this);
  }

  @override
  void notify(Object sender, String event) {
    if (event == "changed" || event == "toggled") {
      _updateSubmitButton();
    }

    if (event == "clicked") {
      print("\nFormulario enviado correctamente.");
      print("  Nombre: ${nameField.value}");
      print("  Correo: ${emailField.value}");
    }
  }

  void _updateSubmitButton() {
    final canSubmit =
        nameField.isValid && emailField.isValid && termsCheckbox.checked;
    submitButton.updateState(canSubmit);
  }
}