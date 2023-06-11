import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_agroup_month.dart';

import '../entities/historical_data_day.dart';

abstract class DayHistoricalDataSource {
  Future<HistoricalDataDay> getTodayHistorical(String stationId, int yyyymmdd);
  Future<List<HistoricalDataDay>> getLastDataBetween(String stationId, int yyyymmddStart, int yyyymmddEnd);
  Future<HistoricalAgroupMonth> getHistoricalDataDayOfAMonth(String stationId, int yyyymm);
}
