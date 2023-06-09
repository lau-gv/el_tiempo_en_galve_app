import 'package:el_tiempo_en_galve_app/features/historicalData/domain/datasources/day_historical_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/day_historical_repository.dart';

class DayHistoricalRepositoryAwsImpl implements DayHistoricalRepository {

  final DayHistoricalDataSource _historicalDataSource;

  DayHistoricalRepositoryAwsImpl({historicalDataSource}): _historicalDataSource = historicalDataSource;

  @override
  Future<Map<int, HistoricalDataDay>> getHistoricalDataDayOfAMonth(String stationId, int yyyymm) {
    // TODO: implement getHistoricalDataDayOfAMonth
    throw UnimplementedError();
  }

  @override
  Future<List<HistoricalDataDay>> getLast7HistoricalDataDays(String stationId, int yyyymmddStart, int yyyymmddEnd) {
    // TODO: implement getLast7HistoricalDataDays
    throw UnimplementedError();
  }

  @override
  Future<HistoricalDataDay> getTodayHistorical(String stationId, int yyyymmdd) async {
    return await _historicalDataSource.getTodayHistorical(stationId, yyyymmdd);
  }
}
