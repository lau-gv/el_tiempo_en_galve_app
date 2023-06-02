import 'package:el_tiempo_en_galve_app/features/auth/presentation/providers/register_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'inputs/inputs.dart';


// 3 - StatenotifierProvider - consume afuera.
//Autodispose es para que cuando ya no se use este churro, se elimine.
final registerFormProvider = StateNotifierProvider<RegisterFormNotifier, RegisterFormState>((ref) {

  final registerUserCallback = ref.watch(registerProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});


// 2 - Como implementanmos un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  
  final Function(String, String, String) registerUserCallback;
  //La creación del estado inicial debe ser síncrona.
  RegisterFormNotifier({required this.registerUserCallback}) : super(RegisterFormState());

  onUsernameChange(String value) {
    final newUsername = Username.dirty(value);
    state = state.copyWith(
        username: newUsername, isValid: Formz.validate([newUsername, state.email, state.password, state.repeatedPassword]));
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail, isValid: Formz.validate([newEmail, state.username, state.password, state.repeatedPassword]));
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword, isValid: Formz.validate([newPassword, state.username, state.email, state.repeatedPassword]));
  }
  onRepeatedPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        repeatedPassword: newPassword, isValid: Formz.validate([newPassword, state.username, state.email, state.password]));
  }

  onFormSubmit() async{
    _touchEveryField();
    state = state.copyWith(isPosting: true, isValidUser: false);
    if( !state.isValid ) return;
    if(!_areEqualsPasswords()) return;
    try{
      final successFullRegister = await registerUserCallback(state.username.value, state.email.value, state.password.value);     
      if(successFullRegister) state = state.copyWith(isValidUser: true);
    } catch (e){
      state = state.copyWith(isValidUser: false, isPosting: false);
    }
    state = state.copyWith(isPosting: false);
  }

  _touchEveryField(){
    final username = Username.dirty(state.username.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final repeatedPassword = Password.dirty(state.repeatedPassword.value);

    state = state.copyWith(
      isFormPosted: true,
      username: username,
      email: email,
      password: password,
      repeatedPassword: repeatedPassword,
      isValid: Formz.validate([username, email, password, repeatedPassword])
    );
  }

  _areEqualsPasswords(){
    final String password = state.password.value;
    final String repeatedPassword = state.repeatedPassword.value;
    return password == repeatedPassword;
  }
}

//! 1 - State del provider
class RegisterFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final bool isValidUser;
  final Username username;
  final Email email;
  final Password password;
  final Password repeatedPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.isValidUser = false,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.repeatedPassword = const Password.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    bool? isValidUser,
    Username? username,
    Email? email,
    Password? password,
    Password? repeatedPassword,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    isValidUser: isValidUser ?? this.isValidUser,
    username: username ?? this.username,
    email: email ?? this.email,
    password: password ?? this.password,
    repeatedPassword: repeatedPassword ?? this.repeatedPassword,
  );

  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    username: $username
    email: $email
    password: $password
    repeatedPassword: $repeatedPassword
''';
  }
}
