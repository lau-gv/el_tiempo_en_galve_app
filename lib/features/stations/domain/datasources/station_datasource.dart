import '../entities/station.dart';

abstract class StationDatasource {

  Future<List<WeatherStation>> getStationsByUser();
  Future<void> deleteStation(WeatherStation weatherStation);
}