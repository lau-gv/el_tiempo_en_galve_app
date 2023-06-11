import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/max_min_day.dart';

class HistoricalAgroupMonth{
  late List<HistoricalDataDay> _historicalDataDays;
  late double _totalRain;
  late MaxMinDay _maxRain;
  late MaxMinDay _maxTemp;
  late MaxMinDay _minTemp;

  HistoricalAgroupMonth() {
    _historicalDataDays = [];
    _totalRain = 0.0;
    _maxRain = MaxMinDay(value: 0.0, day: '');
    _maxTemp = MaxMinDay(value: -800, day: '');
    _minTemp = MaxMinDay(value: 100, day: '');
  }
  
  List<HistoricalDataDay> get historicalDataDays => _historicalDataDays;
  double get totalRain => _totalRain;
  MaxMinDay get maxRain => _maxRain;
  MaxMinDay get maxTemp => _maxTemp;
  MaxMinDay get minTemp => _minTemp;

  void addHistoricalDataDay(HistoricalDataDay historicalDataDay){
    _historicalDataDays.add(historicalDataDay);
    _updateTotalRain(historicalDataDay.acumulateDailyraininmm);
    _setMaxRain(historicalDataDay.acumulateDailyraininmm, historicalDataDay.getDateFormat());
    _setMaxTemp(historicalDataDay.maxTemperature, historicalDataDay.getDateFormat());
    _setMinTemp(historicalDataDay.minTemperature, historicalDataDay.getDateFormat());
  }

  void _setMaxRain(double rain, String day){
    if (_maxRain.value < rain){
      _maxRain = MaxMinDay(value: rain, day: day);
    }
  }
  void _setMaxTemp(double temp, String day){
    if (_maxTemp.value < temp){
      _maxTemp = MaxMinDay(value: temp, day: day);
    }
  }
  void _setMinTemp(double temp, String day){
    if(temp < _minTemp.value){
      _minTemp = MaxMinDay(value: temp, day: day);
    }
  }

  void _updateTotalRain(double rainDay){
    this._totalRain += rainDay;
  }
}