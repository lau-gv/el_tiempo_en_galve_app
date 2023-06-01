import 'package:el_tiempo_en_galve_app/features/auth/domain/entities/unauthenticateUser.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:el_tiempo_en_galve_app/features/auth/domain/domain.dart';
import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/repositories/auth_repository_impl.dart';

import 'auth_provider.dart';



final registerProvider = StateNotifierProvider<RegisterNotifier,RegisterState>((ref) {
  final AuthRespository authRespository = AuthRespositoryImpl();
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  
  return RegisterNotifier(authRespository : authRespository, loginUserCallback: loginUserCallback);
});

class RegisterNotifier extends StateNotifier<RegisterState>{

  final Function(String, String) loginUserCallback;
  final AuthRespository authRespository;

  RegisterNotifier({
    required this.authRespository,
    required this.loginUserCallback,
    }) 
  : super(RegisterState());

  Future<bool> registerUser(String username, String email, String password) async {
    bool successfullyRegister = false;
    try{
      await authRespository.register(username, email, password);
      UnauthenticateUser unauthenticateUser = UnauthenticateUser(email: email, username: username, password: password);
      state = state.copyWith(user: unauthenticateUser);
      successfullyRegister = true;
    } on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message);
    } catch (e){
      state = state.copyWith(errorMessage: '$e');
    }

    return successfullyRegister;
  }

  Future<bool> confirmUser(String confirmCode) async {
    bool isConfirm = false;
    try{
      //Tengo que ver, ¿Cómo confirmo ese email?!!!!!
      isConfirm = await authRespository.confirmEmail(state.user!.username, confirmCode);
      isConfirm 
        ? await loginUserCallback(state.user!.email, state.user!.password)
        : state = state.copyWith(errorMessage: "Invalid code");
      //await loginUser(email, password);
    } on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message);
    } catch (e){
      state = state.copyWith(errorMessage: '$e');
    }

    return isConfirm;
  }

}


class RegisterState {
  final UnauthenticateUser? user;
  final String errorMessage;

  RegisterState({
    this.user, 
    this.errorMessage = ''});

  RegisterState copyWith({UnauthenticateUser? user, String? errorMessage}) => RegisterState(
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage
  );
}
