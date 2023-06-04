
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/ecowitt_station.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/wunderground_station.dart';

import '../../domain/entities/weather_station.dart';
import '../dto/weather_station_dto.dart';

class StationMapper {


  static WeatherStation weatherStationDTOToEntity(WeatherStationDTO stationDTO) {
    final Map<String, Function(WeatherStationDTO)> creationOptions = {
      StationType.ecowitt.name : weatherStationDTOToEcowittEntity,
      StationType.wunderground.name : weatherStationDTOToWunderground,
    };

    final createFunction = creationOptions[stationDTO.type.toLowerCase()];
    return createFunction == null ? null : createFunction(stationDTO);
  }

  static EcowittStation weatherStationDTOToEcowittEntity(WeatherStationDTO dto){
    return EcowittStation(
      id: dto.stationId,
      userId: dto.userId,
      auth: dto.authStation,
      key: dto.key,
      location: dto.location,
      name: dto.name
    );
  }
  static WundergroundStation weatherStationDTOToWunderground(WeatherStationDTO dto){
    return WundergroundStation(
      id: dto.stationId,
      userId: dto.userId,
      auth: dto.authStation,
      key: dto.key,
      location: dto.location,
      name: dto.name
    );
  }

  static WeatherStationDTO weatherStationToDTO(WeatherStation station){
    return WeatherStationDTO(
      stationId: station.id, 
      userId: station.userId, 
      name: station.name, 
      authStation: station.auth, 
      key: station.key, 
      location: station.location, 
      type: station.stationType.name);
  }
}