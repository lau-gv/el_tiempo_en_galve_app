
import '../../../domain/entities/station.dart';

class StationMapper {

  static jsonToEntity(Map<String, dynamic> json) => WeatherStation(
    id: json['id'],
    auth: json['authStation'],
    key: json['key'],
    location: json['location'],
    name: json['name'],
    stationType: json['type'] == "Ecowitt" ? StationType.ecowitt : StationType.wunderground,
    userId: json['userId']
  );
}