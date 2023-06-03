import '../entities/station.dart';

abstract class StationRepository {

  Future<List<WeatherStation>> getStationsByUser();
  Future<bool> deleteStation(WeatherStation weatherStation);
  Future<WeatherStation> createStation(Map<String, dynamic> stationLike);
}