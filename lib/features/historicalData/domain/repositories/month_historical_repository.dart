import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_agroup_year.dart';

abstract class MonthHistoricalRepository {
  Future<HistoricalAgroupYear> getHistoricalMonthOfAYear(String stationId, int yyyy);
}
