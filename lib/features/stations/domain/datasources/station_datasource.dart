import '../entities/weather_station.dart';

abstract class StationDatasource {

  Future<List<WeatherStation>> getStationsByUser();
  Future<bool> deleteStation(WeatherStation weatherStation);
  Future<WeatherStation> createStation(WeatherStation weatherStation);

}