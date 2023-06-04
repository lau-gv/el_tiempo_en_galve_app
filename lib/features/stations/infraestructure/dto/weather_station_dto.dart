class WeatherStationDTO {
  final String stationId;
  final String userId;
  final String name;
  final String authStation;
  final String key;
  final String location;
  final String type;

  WeatherStationDTO(
      {required this.stationId,
      required this.userId,
      required this.name,
      required this.authStation,
      required this.key,
      required this.location,
      required this.type});

  factory WeatherStationDTO.fromJson(Map<String, dynamic> json) {
    return WeatherStationDTO(
      stationId: json['stationId'] ?? "",
      userId: json['userId'] ?? "",
      name: json['name'] ?? "",
      authStation: json['authStation'] ?? "",
      key: json['key'] ?? "",
      location: json['location'] ?? "",
      type: json['type'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stationId': stationId,
      'userId': userId,
      'authStation': authStation,
      'name': name,
      'key': key,
      'location': location,
      'type': type,
    };
  }
}