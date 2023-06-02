import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:el_tiempo_en_galve_app/config/config.dart';
import 'package:el_tiempo_en_galve_app/features/auth/domain/domain.dart';
import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/mappers/userSession_mapper.dart';

class AuthDataSourceCognitoImpl  extends AuthDataSource {
  //Coger del entorno que falta por "iniciar"
  final userPool = CognitoUserPool(
    Enviroment.poolIdCognito,
    Enviroment.clientIdCognito,
  );

  @override
  Future<User> login(String email, String password) async {

  final cognitoUser = CognitoUser(email, userPool);
  final authDetails = AuthenticationDetails(
    username: email,
    password: password,
  );

  
  final CognitoUserSession? session;
  try {
     session = await cognitoUser.authenticateUser(authDetails);

     //print(jwt);
     User user = UserSessionMapper.cognitoSessionToEntity(session!, email, password);
     //print(user.password);
    final token = session.idToken.jwtToken;
    final first500Chars = token?.substring(0, 500);
    final remainingChars = token?.substring(500);
    print(first500Chars);
    print(remainingChars);
     return user;

 
    //Perdí un día por esto, son unas pocas líneas no más, así que, aunque el código se enguarre, aquí se queda
    /*TE AMO STACKOVERFLOW. La enseñanza es que hay que validar las cosas también probándolas desde el código, 
    a veces, escribir más, no es malo, también que no hay que obcecarse en una única forma de abordar algo que no sale y buscar antes en interné
    * https://stackoverflow.com/questions/65178391/flutter-aws-cognito-token-showing-invalid-signature */
    //final first500Chars = token?.substring(0, 500);
    //final remainingChars = token?.substring(500);
    //print(first500Chars);
    //print(remainingChars);
    //print('Token JWT: $token'); // Imprimir el token por pantalla
  } on CognitoUserNewPasswordRequiredException catch (e) {
    //print('CognitoUserNewPasswordRequiredException: $e');
    throw CustomError(message: e.message ?? "");
  } on CognitoUserMfaRequiredException catch (e) {
    //print('CognitoUserMfaRequiredException: $e');
    throw CustomError(message: e.message ?? "");
  } on CognitoUserSelectMfaTypeException catch (e) {
    //print('CognitoUserSelectMfaTypeException: $e');
    throw CustomError(message: e.message ?? "");
  } on CognitoUserMfaSetupException catch (e) {
    //print('CognitoUserMfaSetupException: $e');
    throw CustomError(message: e.message ?? "");
  } on CognitoUserTotpRequiredException catch (e) {
    //print('CognitoUserTotpRequiredException: $e');
    throw CustomError(message: e.message ?? "");
  } on CognitoUserCustomChallengeException catch (e) {
    //print('CognitoUserCustomChallengeException: $e');
    throw CustomError(message: e.message ?? "");
  } on CognitoUserConfirmationNecessaryException catch (e) {
    //print('CognitoUserConfirmationNecessaryException: $e');
    throw CustomError(message: e.message ?? "");
  } on CognitoClientException catch (e) {
    //print('CognitoClientException: $e');
    throw CustomError(message: e.message ?? "", errorCode: e.statusCode);
  } catch (e) {
    //print(e);
    throw Exception();
  }
}



  @override
  Future<void> register(String username, String email, String password) async{
    var data;
    try{
      final userAttributes = [
          AttributeArg(name: 'email', value: email),
      ];
      data = await userPool.signUp(username, password, userAttributes: userAttributes);
    } on CognitoClientException catch(e){
      //print('$e');
      throw CustomError(message: e.message ?? "", errorCode: e.statusCode);
    } catch (e){
      //print('$e');
       throw CustomError(message: '$e');
    }
  }
  
  @override
  Future<bool> confirmEmail(String username, String numberConfirm) async{
    final cognitoUser = CognitoUser(username, userPool);
    bool registrationConfirmed = false;
    try {
      registrationConfirmed = await cognitoUser.confirmRegistration(numberConfirm);
      registrationConfirmed = true;
    } catch (e) {
       print('$e');
      throw CustomError(message: '$e');
    }
    return registrationConfirmed;
  }
}