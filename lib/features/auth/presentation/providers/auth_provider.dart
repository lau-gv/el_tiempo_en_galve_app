import 'package:el_tiempo_en_galve_app/features/auth/domain/domain.dart';
import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/repositories/auth_repository_impl.dart';
import 'package:el_tiempo_en_galve_app/features/shared/infraestructure/services/key_value_storage_service.dart';
import 'package:el_tiempo_en_galve_app/features/shared/infraestructure/services/key_value_storage_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authProvider = StateNotifierProvider<AuthNotifier,AuthState>((ref) {
  final AuthRespository authRespository = AuthRespositoryImpl();
  final KeyValueStorageService keyValueStorageService = KeyValueStorageServiceImpl();
  
  return AuthNotifier(authRespository : authRespository, keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState>{

  final AuthRespository authRespository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({required this.authRespository, required this.keyValueStorageService}) : super(AuthState());

  Future<void> loginUser(String email, String password) async {
    try{
      final user = await authRespository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e){
      logout( e.message);
    } catch (e) {
      logout('Erro no controlado ');
    }   
  }

  Future<void> registerUser(String email, String password) async {

  }

  void checkAuthStatus(String email, String password) async {

  }

  Future<void> logout([ String? errorMessage ]) async {
    //Esto debería tener su propia cosa. Aquí, lo vamos a usar aquí solo? No creo.
    await keyValueStorageService.removeKey('token');
    await keyValueStorageService.removeKey('useremail');
    await keyValueStorageService.removeKey('password');
    await keyValueStorageService.removeKey('username');
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }

  void _setLoggedUser(User user) async{
    //Esto debería tener su propia cosa. Aquí, lo vamos a usar aquí solo? No creo.
    await keyValueStorageService.setKeyValue('token', user.id);
    await keyValueStorageService.setKeyValue('useremail', user.email);
    await keyValueStorageService.setKeyValue('password', user.password);
    await keyValueStorageService.setKeyValue('username', user.username);

    state = state.copyWith(
      user: user,
      errorMessage: '',
      authStatus: AuthStatus.authenticated,
    );
    //TODO: necesito guardar el token físicamente para que sea persistente.
  }

}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errorMessage = ''});

  AuthState copyWith({AuthStatus? authStatus, User? user, String? errorMessage}) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage
  );
}
