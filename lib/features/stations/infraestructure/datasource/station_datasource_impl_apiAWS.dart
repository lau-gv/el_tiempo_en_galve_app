import 'package:dio/dio.dart';
import 'package:el_tiempo_en_galve_app/config/config.dart';
import 'package:el_tiempo_en_galve_app/features/stations/infraestructure/datasource/mappers/station_mapper.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/datasources/station_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/station.dart';

class StationDatasourceImplApiAWS implements StationDatasource {
  
  late final Dio dio;
  final String accessToken;
  final String userId;

  StationDatasourceImplApiAWS({required this.accessToken, required this.userId})
  : dio = Dio(BaseOptions(
    baseUrl: Enviroment.stationApi,
    headers: {
      'Authorization' : '$accessToken'
    }
  ));

  Future<List<WeatherStation>> getStationsByUser() async {
    print(accessToken);
    print(accessToken.length);
    print(userId);
    try {
      final response = await dio.get('/station?userId=$userId');
      final List<WeatherStation> stations = [];
      (response.data ?? []).forEach((station) => stations.add(StationMapper.jsonToEntity(station)));

      return stations;
    }on DioError catch (e) {
      print(e.message);
      print(e.response!.statusCode);
      print(e.response!.statusMessage);
      throw Exception();
    } catch (e){
      print(e);
      throw Exception();
    }
  }
}