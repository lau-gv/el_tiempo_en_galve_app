import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../infraestructure/inputs/inputs.dart';
// 3 - StatenotifierProvider - consume afuera.
//Autodispose es para que cuando ya no se use este churro, se elimine.
final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {
  return RegisterFormNotifier();
});


// 2 - Como implementanmos un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  //La creación del estado inicial debe ser síncrona.
  RegisterFormNotifier() : super(RegisterFormState());

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

  onFormSubmit(){
    _touchEveryField();
    if( !state.isValid ) return;
    if(!_areEqualsPasswords()) return;

    print(state);
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
  final Username username;
  final Email email;
  final Password password;
  final Password repeatedPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.repeatedPassword = const Password.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Username? username,
    Email? email,
    Password? password,
    Password? repeatedPassword,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
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
