import '../entities/station.dart';

abstract class StationRepository {

  Future<List<Station>> getStations({required String userId});
  void deleteStation({required String stationId});
}