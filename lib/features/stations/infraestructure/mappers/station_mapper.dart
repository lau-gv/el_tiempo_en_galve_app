
import '../../domain/entities/station.dart';

class StationMapper {

  static jsonToEntity(Map<String, dynamic> json) => WeatherStation(
    id: json['stationId'] ?? "",
    auth: json['authStation'] ?? "",
    key: json['key'] ?? "",
    location: json['location'] ?? "",
    name: json['name'],
    stationType: json['type'] == "ecowitt" ? StationType.ecowitt : StationType.wunderground,
    userId: json['userId']
  );

  static entityToJson(WeatherStation weatherStation) => {
    "stationId" : weatherStation.id,
    "userId" : weatherStation.userId,
    "authStation" : weatherStation.auth,
    "key" : weatherStation.key,
    "location" : weatherStation.location,
    "type" : weatherStation.stationType.name,
  };
}