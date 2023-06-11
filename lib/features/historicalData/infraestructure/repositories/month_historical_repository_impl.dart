import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/month_historical_repository.dart';

class MonthHistoricalRepositoryImpl implements MonthHistoricalRepository {
  @override
  Future<Map<int, HistoricalDataDay>> getHistoricalMonthOfAYear(String stationId, int yyyymmdd) async {
    // TODO: implement getHistoricalMonthOfAYear
    throw UnimplementedError();
  }
 
}
