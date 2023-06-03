import 'dart:convert';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:el_tiempo_en_galve_app/features/auth/domain/domain.dart';

class UserSessionMapper {

  static cognitoSessionToEntity(CognitoUserSession session, String email, String password) => User(
      id: session.getIdToken().getSub() ?? "",
      email: email,
      username: decodePayload(session.getIdToken().getJwtToken()!)['cognito:username'],
      password: password,
      token: session.getIdToken().getJwtToken() ?? "");

      

  static  dynamic decodePayload(jwtToken) {
    var payload = jwtToken!.split('.')[1];
    if (payload.length % 4 > 0) {
      payload =
          payload.padRight(payload.length + (4 - payload.length % 4), '=');
    }
    try {
      return json.decode(utf8.decode(base64.decode(payload)));
    } catch (err) {
      return {};
    }
  }
}
