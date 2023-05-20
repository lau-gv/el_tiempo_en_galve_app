import 'package:el_tiempo_en_galve_app/features/stations/domain/datasources/station_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/station.dart';

class StationAWSApiGateway extends StationDatasource {
  @override
  void deleteStation({required String stationId}) {
    // TODO: implement deleteStation
  }

  @override
  Future<List<Station>> getStations({required String userId}) {
    // TODO: implement getStations
    throw UnimplementedError();
  }

}