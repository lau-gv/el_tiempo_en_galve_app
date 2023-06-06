import '../../domain/entities/weather_station.dart';
import '../dto/weather_station_create_dto.dart';

class StationCreateMapper {


  static WeatherStationCreateDTO stationToStationCreateDTO(WeatherStation weatherStation, String userId) {
    return WeatherStationCreateDTO(
    userId: userId,
    location: weatherStation.location,
    name: weatherStation.name,
    key: weatherStation.key,
    type: weatherStation.stationType.name,
  );
  } 
}