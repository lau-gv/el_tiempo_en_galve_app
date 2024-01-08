import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';

class HistoricalDataDayAWSMapper{

static HistoricalDataDay fromJson(Map<String, dynamic> json) => HistoricalDataDay(
    datadate: json["datadate"].toInt(),
    stationId: json["stationId"].toString(),
    year: json["year"].toInt(),
    month: json["month"].toInt(),
    day: json["day"].toInt(),
    maxTemperature: json["maxTemperature"].toDouble(),
    minTemperature: json["minTemperature"].toDouble(),
    maxHumidity: json["maxHumidity"].toInt(),
    minHumidity: json["minHumidity"].toInt(),
    maxBaromrelhpa: json["maxBaromrelhpa"].toDouble(),
    minBaromrelhpa: json["minBaromrelhpa"].toDouble(),
    maxBaromabshpa: json["maxBaromabshpa"].toDouble(),
    minBaromabshpa: json["minBaromabshpa"].toDouble(),
    maxRainrateinmm: json["maxRainrateinmm"].toDouble(),
    minRainrateinmm: json["minRainrateinmm"].toDouble(),
    acumulateDailyraininmm: json["acumulateDailyraininmm"].toDouble(),
    maxwindspeedkmh: json["maxwindspeedkmh"].toDouble(),
    minwindspeedkmh: json["minwindspeedkmh"].toDouble(),
    maxdailygust: json["maxdailygust"].toDouble(),
    mindailygust: json["mindailygust"].toDouble(),
    maxSolarradiation: json["maxSolarradiation"].toDouble(),
    minSolarradiation: json["minSolarradiation"].toDouble(),
    maxUv: json["maxUv"].toInt(),
    minUv: json["minUv"].toInt(),
    maxIndoortemp: json["maxIndoortemp"].toDouble(),
    minIndoortemp: json["minIndoortemp"].toDouble(),
    maxIndoorhumidity: json["maxIndoorhumidity"].toInt(),
    minIndoorhumidity: json["minIndoorhumidity"].toInt(),
  );
}