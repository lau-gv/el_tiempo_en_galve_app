import '../entities/historical_data_day.dart';

abstract class DayHistoricalRepository {
  Future<HistoricalDataDay> getTodayHistorical(String stationId, int yyyymmdd);
  Future<void> getLast7HistoricalDataDays(String stationId, int yyyymmddStart, int yyyymmddEnd);
  Future<void> getHistoricalDataDayOfAMonth(String stationId, int yyyymm);

}
