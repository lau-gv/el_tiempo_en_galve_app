import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/weather_station.dart';

class WundergroundStation implements WeatherStation{
  final String _userId;
  final String _id;
  final String _name;
  final String _location;
  final StationType _stationType;
  final String _auth;
  final String _key;

  WundergroundStation({
    String? userId,
    String? id, 
    required String name, 
    required String location, 
    String? auth, 
    String? key,    
  }) : 
    _userId = userId ?? "",
    _id = id ?? "",
    _name = name,
    _location = location,
    _stationType = StationType.ecowitt,
    _auth = auth ?? "",
    _key = key ?? "";

  @override
  String get userId => _userId;
  @override
  String get id => _id;
  @override
  String get name => _name;
  @override
  String get location => _location;
  @override
  StationType get stationType => _stationType;
  @override
  String get auth => _auth;
  @override
  String get key => _key;
}
