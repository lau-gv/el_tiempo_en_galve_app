class WeatherStationCreateDTO{
  final String _userId;
  final String _name;
  final String _location;
  final String? _key;
  final String _type;

  WeatherStationCreateDTO({
    required String userId,
    required String name,
    required String location,
    required String type,
    String? key,
  })  : _userId = userId,
        _name = name,
        _location = location,
        _key = key,
        _type = type;

  String get userId => _userId;
  String get name => _name;
  String get location => _location;
  String? get key => _key;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'name': _name,
      'location': _location,
      'type': _type,
      if(_key != null) 'key': _key,
    };
  }
}