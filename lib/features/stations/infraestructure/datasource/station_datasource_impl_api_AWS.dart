import 'package:dio/dio.dart';
import 'package:el_tiempo_en_galve_app/config/config.dart';
import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:el_tiempo_en_galve_app/features/stations/infraestructure/mappers/station_mapper.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/datasources/station_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/station.dart';

class StationDatasourceImplApiAWS implements StationDatasource {
  
  late final Dio dio;
  final String accessToken;
  final String userId;

  final String apiEndpointAll = "/stations";
  final String apiEndpoint = "/station";

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
 
      final response = await dio.get('$apiEndpointAll?userId=$userId');
      final List<WeatherStation> stations = [];
      (response.data ?? []).forEach((station) => stations.add(StationMapper.jsonToEntity(station)));

      return stations;
    }on DioError catch (e) {
      throw CustomError(message: e.message != null ? e.message! : "");
    } catch (e){
      throw Exception();
    }
  }
  
  @override
  Future<bool> deleteStation(WeatherStation weatherStation) async {
    bool succesfullElimination = false;
    
    try{
      await dio.delete(
        apiEndpoint,
        data: StationMapper.entityToJson(weatherStation),
        options: Options(
        headers: {'Content-Type': 'application/json'},
      ));
      succesfullElimination = true;
    }on DioError catch (e) {
      print(e.response);
      throw CustomError(message: e.message != null ? e.message! : "");
    } catch (e){
      throw CustomError(message: '$e');
    }
    return succesfullElimination;
  }
  
  @override
  Future<WeatherStation> createStation(Map<String, dynamic> stationLike) async{
    stationLike["userId"] = userId;
    try{
      final response = await dio.post(
        apiEndpoint,
        data: stationLike,
        options: Options(
        headers: {'Content-Type': 'application/json'},
      ));
    return StationMapper.jsonToEntity(response.data);
    }on DioError catch (e) {
      throw CustomError(message: e.message != null ? e.message! : "");
    } catch (e){
      throw CustomError(message: '$e');
    }
  }  
}