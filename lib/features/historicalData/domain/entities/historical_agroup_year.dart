import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_month.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/max_min_day.dart';

class HistoricalAgroupYear{
  late List<HistoricalDataMonth> _historicalDataMonth;
  late double _totalRain;
  late MaxMinDay _maxRain;
  late MaxMinDay _maxTemp;
  late MaxMinDay _minTemp;

  HistoricalAgroupYear() {
    _historicalDataMonth = [];
    _totalRain = 0.0;
    _maxRain = MaxMinDay(value: 0.0, date: '');
    _maxTemp = MaxMinDay(value: -800, date: '');
    _minTemp = MaxMinDay(value: 100, date: '');
  }
  
  List<HistoricalDataMonth> get historicalDataMonth => _historicalDataMonth;
  double get totalRain => _totalRain;
  MaxMinDay get maxRain => _maxRain;
  MaxMinDay get maxTemp => _maxTemp;
  MaxMinDay get minTemp => _minTemp;

  void addHistoricalDataMonth(HistoricalDataMonth historicalDataMonth){
    _historicalDataMonth.add(historicalDataMonth);
    _updateTotalRain(historicalDataMonth.acumulateDailyraininmm);
    _setMaxRain(historicalDataMonth.acumulateDailyraininmm, historicalDataMonth.getDateFormat());
    _setMaxTemp(historicalDataMonth.maxTemperature, historicalDataMonth.getDateFormat());
    _setMinTemp(historicalDataMonth.minTemperature, historicalDataMonth.getDateFormat());
  }

  void _setMaxRain(double rain, String day){
    if (_maxRain.value < rain){
      _maxRain = MaxMinDay(value: rain, date: day);
    }
  }
  void _setMaxTemp(double temp, String day){
    if (_maxTemp.value < temp){
      _maxTemp = MaxMinDay(value: temp, date: day);
    }
  }
  void _setMinTemp(double temp, String day){
    if(temp < _minTemp.value){
      _minTemp = MaxMinDay(value: temp, date: day);
    }
  }

  void _updateTotalRain(double rainDay){
    _totalRain += rainDay;
  }
}