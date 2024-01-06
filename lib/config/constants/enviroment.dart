import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {

  static initEnviroment() async {
    await dotenv.load(fileName: '.env');
  }
  static String poolIdCognito = dotenv.env['POOL_ID'] ?? 'Cognito Pool ID not configured' ;
  static String clientIdCognito = dotenv.env['CLIENT_ID'] ?? 'Cognito clientID not configure';
  static String region = dotenv.env['REGION'] ?? 'Cognito Region not configure';
  static String stationApi = dotenv.env['STATION_API'] ?? 'stationApiNotConfigure';
  static String historicalDataApi = dotenv.env['HISTORICAL_DATA_API'] ?? 'Historical data api not configured';
  //¡¡YA LO SÉ. YA LO SÉ :(!!!!!
  static String stationId = dotenv.env['STATION_ID'] ?? 'stationApiNotConfigure';
  static String historicalDataApikey = dotenv.env['HISTORICAL_DATA_API_KEY'] ?? 'historical data api not configure';
}