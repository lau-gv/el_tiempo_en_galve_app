import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:el_tiempo_en_galve_app/features/auth/domain/domain.dart';
import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/repositories/auth_repository_impl.dart';
import 'package:el_tiempo_en_galve_app/features/shared/infraestructure/services/key_value_storage_service.dart';
import 'package:el_tiempo_en_galve_app/features/shared/infraestructure/services/key_value_storage_service_impl.dart';



final authProvider = StateNotifierProvider<AuthNotifier,AuthState>((ref) {
  final AuthRespository authRespository = AuthRespositoryImpl();
  final KeyValueStorageService keyValueStorageService = KeyValueStorageServiceImpl();
  
  return AuthNotifier(authRespository : authRespository, keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState>{

  final AuthRespository authRespository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRespository, 
    required this.keyValueStorageService}) 
  : super(AuthState()){
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    try{
      final user = await authRespository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e){
      logout( e.message);
    } catch (e) {
      logout('Error no controlado');
    }   
  }

    Future<void> registerUser(String username, String email, String password) async {
    try{
      await authRespository.register(username, email, password);
      //await loginUser(email, password);
    } on CustomError catch (e){
      logout( e.message);
    } catch (e) {
      logout('Error no controlado');
    }   
  }


  //Autologin
  void checkAuthStatus() async {
    final usermail = await keyValueStorageService.getValue<String>("useremail");
    final password = await keyValueStorageService.getValue<String>("password");
    //await keyValueStorageService.removeKey('username');
    if(usermail == null || password == null ) return logout();

    try{
      loginUser(usermail, password);
    } catch (e){
      logout();
    }
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
    //La priemra vez que un  usuario se loguea, se guardan sus credenciales de forma automática aunque no quiera XD.
    //Entonces, la próxima vez que abra la aplicación, ya autoiniciaremos sesión, PERO SÍ QUE HABRÁ QUE refrescar el token. Porque caduca, a la hora? XD
    //Pero lo voy a configurar al día porque es que joer es que joer. Debería cambiar y utilizar la sesión que me proporciona Cognito? Está bien que haya 
    //datasources que se comunican con otros, se guarda eso en flutteR?. !!!!!!AAAHHHHH!!!!!!  
    //Quiero esto así para ahorrarme trabajo
    //También, es muy muy mala práctica que estoy utilizando shared preferences para guardar UNA CONTRASEÑA Y UN TOKEN!!! AAAAH AAAAH.
    //aaah!!! pero estoy siguiendo el ejemplo y en el futuro, la cambiaré a el de cifrado. 
    //Laura casi que olvidó como programar y perdió su soltura. Lau triste :(
    //También, 
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
