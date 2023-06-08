import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/day_historical_repository.dart';

class DayHistoricalRepositoryAwsImpl implements DayHistoricalRepository {
  @override
  Future<void> getHistoricalDataDayOfAMonth(String stationId, int yyyymm) {
    // TODO: implement getHistoricalDataDayOfAMonth
    throw UnimplementedError();
  }

  @override
  Future<void> getLast7HistoricalDataDays(String stationId, int yyyymmddStart, int yyyymmddEnd) {
    // TODO: implement getLast7HistoricalDataDays
    throw UnimplementedError();
  }

  @override
  Future<HistoricalDataDay> getTodayHistorical(String stationId, int yyyymmdd) {
    // TODO: implement getTodayHistorical
    throw UnimplementedError();
  }
}
