import 'package:formz/formz.dart';

// Define input validation errors
enum ConfirmationCodeError { empty}

// Extend FormzInput and provide the input type and error type.
class ConfirmationCode extends FormzInput<String, ConfirmationCodeError> {

/*Requisitos de Cognito
8: longitud mínima de caracteres
Contiene al menos 1 número
Contiene al menos una letra minúscula
Contiene al menos una letra mayúscula
Contiene al menos 1 carácter especial del siguiente conjunto o un carácter de espacio que no es inicial ni final.
^ $ * . [ ] { } ( ) ? - " ! @ # % & / \ , > < ' : ; | _ ~ ` + = 
*/
  // Call super.pure to represent an unmodified form input.
  const ConfirmationCode.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ConfirmationCode.dirty( super.value ) : super.dirty();


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == ConfirmationCodeError.empty ) return 'El campo es requerido';
    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  ConfirmationCodeError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return ConfirmationCodeError.empty;
    return null;
  }
}