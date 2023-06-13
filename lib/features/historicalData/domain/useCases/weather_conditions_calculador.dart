import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/current_station_data.dart';

enum WeatherCondition {
  dayRainy,
  dayRainyWithWind,
  sunny,
  sunnyWithWind,
  sunnyCloudyWithWind,
  sunnyCloudy,
  nigthRainy,
  moonlit,
  moonlitWithWind,
}

class WeatherConditionCalculator {
  final CurrentStationData _stationData;

  WeatherConditionCalculator(this._stationData);

  WeatherCondition getWeatherCondition(DateTime dateTime){
    if(isDay(dateTime)){
      return getDayWeatherCondition();
    }else{
      return getNigthWeatherCondition();
    }
  }

  bool isDay(DateTime dateTime){
      return (dateTime.hour < 21 && dateTime.hour > 6 || _stationData.solarradiation > 0);
  }

  WeatherCondition getDayWeatherCondition() {
    if (_stationData.rainrateinmm > 0 && _stationData.windspeedkmh > 45) {
      return WeatherCondition.dayRainyWithWind;
    } else if (_stationData.rainrateinmm > 0){
      return WeatherCondition.dayRainy;
    } else if (_stationData.solarradiation < 300 && _stationData.windspeedkmh > 45 && _stationData.humidity > 80){
      return WeatherCondition.sunnyCloudyWithWind;
    } else if (_stationData.solarradiation < 300 && _stationData.humidity > 80 || _stationData.solarradiation < 150){
      return WeatherCondition.sunnyCloudy;
    } else if (_stationData.windspeedkmh > 45) {
      return WeatherCondition.sunnyWithWind;
    } else {
      return WeatherCondition.sunny;
    } 
  }
  WeatherCondition getNigthWeatherCondition() {
    if (_stationData.rainrateinmm > 0) {
      return WeatherCondition.nigthRainy;
    } else if (_stationData.windspeedkmh > 45) {
      return WeatherCondition.moonlitWithWind;
    } else {
      return WeatherCondition.moonlit;
    } 
  }


}
