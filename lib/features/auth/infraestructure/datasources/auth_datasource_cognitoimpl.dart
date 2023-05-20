import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:el_tiempo_en_galve_app/config/config.dart';
import 'package:el_tiempo_en_galve_app/features/auth/domain/domain.dart';

class AuthDataSourceCognitoImpl  extends AuthDataSource {
  //Coger del entorno que falta por "iniciar"
  final userPool = CognitoUserPool(
    Enviroment.poolIdCognito,
    Enviroment.clientIdCognito,
  );
  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {

  final cognitoUser = CognitoUser(email, userPool);
  final authDetails = AuthenticationDetails(
    username: email,
    password: password,
  );

  try {
    final session = await cognitoUser.authenticateUser(authDetails);
    // Obtener el token JWT de la sesión
    final token = session!.getIdToken().getJwtToken();
    
    //Perdí un día por esto, son unas pocas líneas no más, así que, aunque el código se enguarre, aquí se queda
    /*TE AMO STACK OVERFLOW. La enseñanza es que hay que validar las cosas también probándolas desde el código, 
    a veces, escribir más, no es malo, también que no hay que obcecarse en una única forma de resolver y buscar antes en interné
    * https://stackoverflow.com/questions/65178391/flutter-aws-cognito-token-showing-invalid-signature*/
    //final first500Chars = token?.substring(0, 500);
    //final remainingChars = token?.substring(500);
    //print(first500Chars);
    //print(remainingChars);
    //print('Token JWT: $token'); // Imprimir el token por pantalla

  } on CognitoUserNewPasswordRequiredException catch (e) {
    print('CognitoUserNewPasswordRequiredException: $e');
  } on CognitoUserMfaRequiredException catch (e) {
    print('CognitoUserMfaRequiredException: $e');
  } on CognitoUserSelectMfaTypeException catch (e) {
    print('CognitoUserSelectMfaTypeException: $e');
  } on CognitoUserMfaSetupException catch (e) {
    print('CognitoUserMfaSetupException: $e');
  } on CognitoUserTotpRequiredException catch (e) {
    print('CognitoUserTotpRequiredException: $e');
  } on CognitoUserCustomChallengeException catch (e) {
    print('CognitoUserCustomChallengeException: $e');
  } on CognitoUserConfirmationNecessaryException catch (e) {
    print('CognitoUserConfirmationNecessaryException: $e');
  } on CognitoClientException catch (e) {
    print('CognitoClientException: $e');
  } catch (e) {
    print(e);
  }
  //TODO
  return User(id: "id", email: "email", username: "username", token: "token");
}

  @override
  Future<User> register(String username, String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}