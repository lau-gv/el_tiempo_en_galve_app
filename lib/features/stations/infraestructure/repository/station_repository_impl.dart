import 'package:el_tiempo_en_galve_app/features/stations/domain/datasources/station_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/weather_station.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/repositories/station_repository.dart';

class StationRepositoryImpl extends StationRepository {
  
  final StationDatasource datasource;

  StationRepositoryImpl(this.datasource);


  @override
  Future<List<WeatherStation>> getStationsByUser() async {
    return await datasource.getStationsByUser();
  }
  
  @override
  Future<bool> deleteStation(WeatherStation weatherStation) async {
    return await datasource.deleteStation(weatherStation);
  }
    @override
  Future<WeatherStation> createStation(WeatherStation weatherStation) async {
    return await datasource.createStation(weatherStation);
  }
}