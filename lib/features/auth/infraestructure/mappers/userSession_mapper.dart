import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:el_tiempo_en_galve_app/features/auth/domain/domain.dart';

class UserSessionMapper {

  static cognitoSessionToEntity(CognitoUserSession session) => User(
      id: session.getIdToken().getSub() ?? "",
      email: "session",
      username: "username",
      token: session.getIdToken().getJwtToken() ?? "");
}
