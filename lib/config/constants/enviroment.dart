import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {

  static initEnviroment() async {
    await dotenv.load(fileName: '.env');
  }
  static String poolIdCognito = dotenv.env['POOL_ID'] ?? 'Cognito Pool ID not configured' ;
  static String clientIdCognito = dotenv.env['CLIENT_ID'] ?? 'Cognito clientID not configure';
  static String region = dotenv.env['REGION'] ?? 'Cognito Region not configure';

}