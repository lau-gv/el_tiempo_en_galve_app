import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/wunderground_station.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/useCases/create_new_station.dart';

import '../entities/weather_station.dart';

class CreateWundergroundNewStation implements CreateNewStation{
  @override
  WeatherStation createnewStation(String name, String location, String? key, String? id, String? auth, String? userId) {
    return WundergroundStation(
      name: name,
      location: location,
      auth: auth,
      id: id,
      key: key,
      userId: userId,
    );
  }

} 

