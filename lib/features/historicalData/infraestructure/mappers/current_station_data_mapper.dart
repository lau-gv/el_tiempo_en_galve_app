import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/station_data.dart';

class CurrentStationDataAWSMapper{

static StationData fromJson(Map<String, dynamic> json) {
    StationData currentStationData = StationData(
      stationId: json["stationId"].toString(),
      datadatetime: json["datadatetime"].toInt(),
      temperature: json["temperature"].toDouble(),
      humidity: json["humidity"].toInt(),
      baromrelhpa: json["baromrelhpa"].toDouble(),
      baromabshpa: json["baromabshpa"].toDouble(),
      rainrateinmm: json["rainrateinmm"].toDouble(),
      eventraininmm: json["eventraininmm"]?.toDouble(),
      hourlyraininmm: json["hourlyraininmm"].toDouble(),
      dailyraininmm: json["dailyraininmm"].toDouble(),
      weeklyraininmm: json["weeklyraininmm"].toDouble(),
      monthlyraininmm: json["monthlyraininmm"].toDouble(),
      yearlyraininmm: json["yearlyraininmm"].toDouble(),
      winddir: json["winddir"].toDouble(),
      windspeedkmh: json["windspeedkmh"].toDouble(),
      windguskmh: json["windguskmh"].toDouble(),
      maxdailygust: json["maxdailygust"].toDouble(),
      solarradiation: json["solarradiation"].toDouble(),
      uv: json["uv"].toInt(),
      dewptfC: json["dewptfC"]?.toDouble(),
      windchillC: json["windchillC"]?.toDouble(),
      indoortempf: json["indoortempf"].toDouble(),
      indoorhumidity: json["indoorhumidity"].toInt(),
    );
  return currentStationData;
  }
}