import 'package:el_tiempo_en_galve_app/features/stations/domain/datasources/station_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/station.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/repositories/station_repository.dart';

class StationRepositoryImpl extends StationRepository {
  
  final StationDatasource datasource;

  StationRepositoryImpl(this.datasource);

  @override
  void deleteStation({required String stationId}) {
    // TODO: implement deleteStation
  }

  @override
  Future<List<WeatherStation>> getStationsByUser() {
    return datasource.getStationsByUser();
  }

}