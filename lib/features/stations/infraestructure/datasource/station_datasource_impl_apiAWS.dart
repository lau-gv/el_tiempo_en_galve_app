import 'package:dio/dio.dart';
import 'package:el_tiempo_en_galve_app/config/config.dart';
import 'package:el_tiempo_en_galve_app/features/stations/infraestructure/datasource/mappers/station_mapper.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/datasources/station_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/station.dart';

class StationDatasourceImplApiAWS implements StationDatasource {
  
  late final Dio dio;
  final String accessToken;
  final String userId;

  final String apiEndpoint = "/stations";

  StationDatasourceImplApiAWS({required this.accessToken, required this.userId})
  : dio = Dio(BaseOptions(
    baseUrl: Enviroment.stationApi,
    headers: {
      'Authorization' : accessToken
    }
  ));

  @override
  Future<List<WeatherStation>> getStationsByUser() async {
    try {
      final response = await dio.get('$apiEndpoint?userId=$userId');
      final List<WeatherStation> stations = [];
      (response.data ?? []).forEach((station) => stations.add(StationMapper.jsonToEntity(station)));

      return stations;
    }on DioError catch (e) {
      throw Exception();
    } catch (e){
      throw Exception();
    }
  }
  
  @override
  Future<WeatherStation> deleteStation() {
    // TODO: implement deleteStation
    throw UnimplementedError();
  }
  
}