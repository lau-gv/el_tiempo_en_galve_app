import '../entities/station.dart';

abstract class StationDatasource {

  Future<List<WeatherStation>> getStationsByUser();
  Future<WeatherStation> deleteStation();
}