import 'package:el_tiempo_en_galve_app/features/stations/domain/useCases/create_new_ecowitt_station.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/useCases/create_new_wunderground_station.dart';

import '../entities/weather_station.dart';
import 'create_new_station.dart';

class CreateStationManager {
  final Map<StationType, CreateNewStation> _creationOptions;

  CreateStationManager()
    : _creationOptions = {
        StationType.ecowitt: CreateEcowittNewStation(),
        StationType.wunderground: CreateWundergroundNewStation(),
      };
  
  //Esto de aqúi no me termina de gustar
  WeatherStation createNewStation(StationType stationType,
  String name, String location, String? key
  ){
    return _creationOptions[stationType]!.createnewStation(name, location, key);
  }
}
