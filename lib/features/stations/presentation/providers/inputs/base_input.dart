import 'package:formz/formz.dart';

enum BaseInputError { empty }

class BaseInput extends FormzInput<String, BaseInputError> {


  const BaseInput.pure() : super.pure('');
  const BaseInput.dirty( super.value ) : super.dirty();



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == BaseInputError.empty ) return 'El campo es requerido';

    return null;
  }

  @override
  BaseInputError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return BaseInputError.empty;
    return null;
  }
}