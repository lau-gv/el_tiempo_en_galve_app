import '../entities/station.dart';

abstract class StationRepository {

  Future<List<WeatherStation>> getStationsByUser();
  void deleteStation({required String stationId});
}