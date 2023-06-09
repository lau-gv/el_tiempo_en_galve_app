import '../entities/historical_data_day.dart';

abstract class DayHistoricalRepository {
  Future<HistoricalDataDay> getTodayHistorical(String stationId, int yyyymmdd);
  Future<List<HistoricalDataDay>> getLast7HistoricalDataDays(String stationId, int yyyymmddStart, int yyyymmddEnd);
  Future<Map<int, HistoricalDataDay>> getHistoricalDataDayOfAMonth(String stationId, int yyyymm);
}
