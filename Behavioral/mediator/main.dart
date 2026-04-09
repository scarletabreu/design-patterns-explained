import 'component/input_field.dart';
import 'component/checkbox.dart';
import 'component/submit_button.dart';
import 'mediator/form_mediator.dart';

void main() {
  final nameField = InputField("Nombre");
  final emailField = InputField("Correo");
  final termsCheckbox = Checkbox("Términos y condiciones");
  final submitButton = SubmitButton();

  FormMediator(
    nameField: nameField,
    emailField: emailField,
    termsCheckbox: termsCheckbox,
    submitButton: submitButton,
  );

  nameField.setValue("Ana García");
  emailField.setValue("ana@ejemplo.com");
  termsCheckbox.toggle();

  print("\n--- Intentando enviar ---");
  submitButton.click();
}