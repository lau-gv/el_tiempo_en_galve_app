import '../entities/station.dart';

abstract class StationDatasource {

  Future<List<Station>> getStations({required String userId});
  void deleteStation({required String stationId});
  

}