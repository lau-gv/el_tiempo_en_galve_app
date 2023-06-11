import 'package:el_tiempo_en_galve_app/features/historicalData/domain/datasources/day_historical_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_month.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/day_historical_repository.dart';

class DayHistoricalRepositoryImpl implements DayHistoricalRepository {

  final DayHistoricalDataSource _historicalDataSource;

  DayHistoricalRepositoryImpl({historicalDataSource}): _historicalDataSource = historicalDataSource;

  @override
  Future<HistoricalMonth> getHistoricalDataDayOfAMonth(String stationId, int yyyymm) async {
    return await _historicalDataSource.getHistoricalDataDayOfAMonth(stationId, yyyymm);
  }

  @override
  Future<List<HistoricalDataDay>> getLastDataBetween(String stationId, int yyyymmddStart, int yyyymmddEnd) async{
    return await _historicalDataSource.getLastDataBetween(stationId, yyyymmddStart, yyyymmddEnd);

  }

  @override
  Future<HistoricalDataDay> getTodayHistorical(String stationId, int yyyymmdd) async {
    return await _historicalDataSource.getTodayHistorical(stationId, yyyymmdd);
  }
}
