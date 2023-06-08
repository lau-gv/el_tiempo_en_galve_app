

import '../entities/historical_data_day.dart';

abstract class MonthHistoricalRepository {
  Future<Map<int, HistoricalDataDay>> getHistoricalMonthOfAYear(String stationId, int yyyymmdd);
}
