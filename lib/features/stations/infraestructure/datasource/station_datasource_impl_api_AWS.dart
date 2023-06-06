import 'package:dio/dio.dart';
import 'package:el_tiempo_en_galve_app/config/config.dart';
import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:el_tiempo_en_galve_app/features/stations/infraestructure/dto/weather_station_dto.dart';
import 'package:el_tiempo_en_galve_app/features/stations/infraestructure/mappers/station_create_mapper.dart';
import 'package:el_tiempo_en_galve_app/features/stations/infraestructure/mappers/station_mapper.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/datasources/station_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/weather_station.dart';

class StationDatasourceImplApiAws implements StationDatasource {
  
  late final Dio dio;
  final String accessToken;
  final String userId;

  final String apiEndpointAll = "/stations";
  final String apiEndpoint = "/station";

  StationDatasourceImplApiAws({required this.accessToken, required this.userId})
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
      (response.data ?? []).forEach((station) => stations.add(StationMapper.weatherStationDTOToEntity(
        WeatherStationDTO.fromJson(station)
      )));
      
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
        data: StationMapper.weatherStationToDTO(weatherStation).toJson(),
        options: Options(
        headers: {'Content-Type': 'application/json'},
      ));
      succesfullElimination = true;
    }on DioError catch (e) {
      throw CustomError(message: e.message != null ? e.message! : "");
    } catch (e){
      throw CustomError(message: '$e');
    }
    return succesfullElimination;
  }
  
  @override
  Future<WeatherStation> createStation(WeatherStation weatherStation) async{    
    try{
      final dtoEs = StationCreateMapper.stationToStationCreateDTO(weatherStation, userId);
      final response = await dio.post(
        apiEndpoint,
        data: dtoEs.toJson(),
        options: Options(
        headers: {'Content-Type': 'application/json'},
      ));
      
      final weatherStationDTO = WeatherStationDTO.fromJson(response.data);
      return StationMapper.weatherStationDTOToEntity(weatherStationDTO);
    }on DioError catch (e) {
      throw CustomError(message: e.message != null ? e.message! : "");
    } catch (e){
      throw CustomError(message: '$e');
    }
  }
  
  @override
  Future<WeatherStation> editStation(WeatherStation weatherStation) async{
    
    try{
      final dtoEs = StationMapper.weatherStationToDTO(weatherStation);
      final response = await dio.put(
        apiEndpoint,
        data: dtoEs.toJson(),
        options: Options(
        headers: {'Content-Type': 'application/json'},
      ));
      
      final weatherStationDTO = WeatherStationDTO.fromJson(response.data);
      return StationMapper.weatherStationDTOToEntity(weatherStationDTO);
    }on DioError catch (e) {
      throw CustomError(message: e.message != null ? e.message! : "");
    } catch (e){
      throw CustomError(message: '$e');
    }
    
  }  
}