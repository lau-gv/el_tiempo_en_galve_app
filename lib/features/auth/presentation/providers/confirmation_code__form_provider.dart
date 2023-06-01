


// 3 - StatenotifierProvider - consume afuera.
//Autodispose es para que cuando ya no se use este churro, se elimine.
import 'package:el_tiempo_en_galve_app/features/auth/presentation/providers/register_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../shared/infraestructure/inputs/inputs.dart';
import '../../infraestructure/errors/auth_errors.dart';


final confirmationCodeProvider = StateNotifierProvider.autoDispose<ConfirmationCodeFormNotifier, ConfirmFormState>((ref) {

  final confirmUserCallback = ref.watch(registerProvider.notifier).confirmUser;
  return ConfirmationCodeFormNotifier(confirmUserCallback: confirmUserCallback);
});


// 2 - Como implementanmos un notifier
class ConfirmationCodeFormNotifier extends StateNotifier<ConfirmFormState> {
  
  final Function(String,) confirmUserCallback;
  //La creación del estado inicial debe ser síncrona.
  ConfirmationCodeFormNotifier({required this.confirmUserCallback}) : super(ConfirmFormState());

  onConfirmationCodeChange(String value) {
    final newCode = ConfirmationCode.dirty(value);
    state = state.copyWith(
      confirmationCode: newCode,
      isValid: Formz.validate([newCode])
    );
  }
  
  onFormSubmit() async{
    _touchEveryField();
    state = state.copyWith(isPosting: true);
    if( !state.isValid ) return;

    try{
      bool isConfirm = await confirmUserCallback(state.confirmationCode.value);
      if(isConfirm) state = state.copyWith(isUserConfirmed: true);
    } catch (e){
      state = state.copyWith(isPosting: false);
    }
    state = state.copyWith(isPosting: false);
  }

  _touchEveryField(){
    final confirmationCode = ConfirmationCode.dirty(state.confirmationCode.value);

    state = state.copyWith(
      isFormPosted: true,
      isValid: Formz.validate([confirmationCode]),
      confirmationCode: confirmationCode
    );
  }

}

class ConfirmFormState{
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final bool isUserConfirmed;
  final ConfirmationCode confirmationCode;

  ConfirmFormState({
    this.isPosting = false, 
    this.isFormPosted = false,
    this.isValid = false, 
    this.isUserConfirmed = false,
    this.confirmationCode = const ConfirmationCode.pure()
  });

  ConfirmFormState copyWith({
      bool? isPosting,
      bool? isFormPosted,
      bool? isValid,
      bool? isUserConfirmed,
      ConfirmationCode? confirmationCode
    }) => ConfirmFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      isUserConfirmed: isUserConfirmed ?? this.isUserConfirmed,
      confirmationCode: confirmationCode ?? this.confirmationCode,
    );

}
