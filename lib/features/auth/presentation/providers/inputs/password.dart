import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class Password extends FormzInput<String, PasswordError> {

/*Requisitos de Cognito
8: longitud mínima de caracteres
Contiene al menos 1 número
Contiene al menos una letra minúscula
Contiene al menos una letra mayúscula
Contiene al menos 1 carácter especial del siguiente conjunto o un carácter de espacio que no es inicial ni final.
^ $ * . [ ] { } ( ) ? - " ! @ # % & / \ , > < ' : ; | _ ~ ` + = 
*/
static final RegExp passwordRegExp = RegExp(
  //Dejamos las comillas como que no se aceptan y punto, porque NO CONSIGO ESCAPARLAS.
  r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\^\$\*\.\[\]\{\}\(\)\?/\,\>\<\:\;\|\_\~\`\+\=\'\\])");
  // Call super.pure to represent an unmodified form input.
  const Password.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Password.dirty( super.value ) : super.dirty();


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == PasswordError.empty ) return 'El campo es requerido';
    if ( displayError == PasswordError.length ) return 'Mínimo 8 caracteres';
    if ( displayError == PasswordError.format ) return 'Debe de tener mayúscula, letras, un número y un caracter especial';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  PasswordError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return PasswordError.empty;
    if ( value.length < 8 ) return PasswordError.length;
    if ( !passwordRegExp.hasMatch(value) ) return PasswordError.format;

    return null;
  }
}