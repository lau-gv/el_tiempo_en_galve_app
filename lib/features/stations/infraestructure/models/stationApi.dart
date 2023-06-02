enum StationType {
   ecowitt,
   wunderground,
}

//String ecowitt = StationType.ecowitt.name; // Ecowit.

class StationApi {
  final String _userId;
  final String _id;
  final String _name;
  final String _location;
  final String _stationType;
  final String _auth;
  final String? _key;

  StationApi({
    required String userId,
    required String id, 
    required String name, 
    required String location, 
    required String stationType, 
    required String auth, 
    String? key,
  }) : 
    _userId = userId,
    _id = id,
    _name = name,
    _location = location,
    _stationType = stationType,
    _auth = auth,
    _key = key;

  String get userId => _userId;
  String get id => _id;
  String get name => _name;
  String get location => _location;
  String get stationType => _stationType;
  String get auth => _auth;
  String? get key => _key;

  Map<String, dynamic> toJson() => {
      "userId": userId,
      "id": id,
      "name": name,
      "location": location,
      "stationType": stationType,
      "auth": auth,
  };
}
