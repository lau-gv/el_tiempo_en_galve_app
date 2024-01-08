import 'package:formz/formz.dart';

// Define input validation errors
enum UsernameError { empty, length, }

// Extend FormzInput and provide the input type and error type.
class Username extends FormzInput<String, UsernameError> {

/*Requisitos de Cognito
8: longitud mínima de caracteres
Contiene al menos 1 número
Contiene al menos una letra minúscula
Contiene al menos una letra mayúscula
Contiene al menos 1 carácter especial del siguiente conjunto o un carácter de espacio que no es inicial ni final.
^ $ * . [ ] { } ( ) ? - " ! @ # % & / \ , > < ' : ; | _ ~ ` + = 
*/
  // Call super.pure to represent an unmodified form input.
  const Username.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Username.dirty( super.value ) : super.dirty();


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == UsernameError.empty ) return 'El campo es requerido';
    if ( displayError == UsernameError.length ) return 'Mínimo 4 caracteres';
    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  UsernameError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return UsernameError.empty;
    if ( value.length < 4 ) return UsernameError.length;

    return null;
  }
}