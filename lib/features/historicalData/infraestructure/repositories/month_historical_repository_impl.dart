import 'package:el_tiempo_en_galve_app/features/historicalData/domain/datasources/month_historical_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_agroup_year.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/month_historical_repository.dart';

class MonthHistoricalRepositoryImpl implements MonthHistoricalRepository {
  final MonthHistoricalDataSource _historicalDataSource;

  MonthHistoricalRepositoryImpl({historicalDataSource})
      : _historicalDataSource = historicalDataSource;

  @override
  Future<HistoricalAgroupYear> getHistoricalMonthOfAYear(
      String stationId, int yyyy) async {
    return await _historicalDataSource.getHistoricalMonthOfAYear(stationId, yyyy);
  }
}
