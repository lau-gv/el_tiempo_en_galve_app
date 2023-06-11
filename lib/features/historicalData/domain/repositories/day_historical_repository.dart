import '../entities/historical_data_day.dart';
import '../entities/historical_agroup_month.dart';

abstract class DayHistoricalRepository {
  Future<HistoricalDataDay> getTodayHistorical(String stationId, int yyyymmdd);
  Future<List<HistoricalDataDay>> getLastDataBetween(String stationId, int yyyymmddStart, int yyyymmddEnd);
  Future<HistoricalAgroupMonth> getHistoricalDataDayOfAMonth(String stationId, int yyyymm);
}
