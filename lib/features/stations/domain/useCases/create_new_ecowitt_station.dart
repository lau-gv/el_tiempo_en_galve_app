import 'dart:convert';

import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/ecowitt_station.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/useCases/create_new_station.dart';

import '../../../auth/infraestructure/errors/auth_errors.dart';
import '../entities/weather_station.dart';

class CreateEcowittNewStation implements CreateNewStation{
  @override
  WeatherStation createnewStation(String name, String location, String? key, String? id, String? auth, String? userId) {
    if(key == null) throw CustomError(message: "required auth parameter");
    return EcowittStation(
      name: name,
      location: location,
      key: key,
      id: id,
      auth: auth,
      userId: userId,
    );
  }

} 

