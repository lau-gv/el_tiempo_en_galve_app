import 'package:el_tiempo_en_galve_app/features/historicalData/domain/datasources/station_historical_data_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/station_data.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/station_historical_data_repository.dart';

class StationHistoricalDataRepositoryImpl implements StationHistoricalDataRepository {
  final StationHistoricalDataDatasource _stationHistoricalDataSource;

  StationHistoricalDataRepositoryImpl({stationHistoricalDataSource})
      : _stationHistoricalDataSource = stationHistoricalDataSource;

  @override
  Future<List<StationData>> getStationHistoricalBetweenDate(String stationId, int yyyymmddhhmmssStart, int yyyymmddhhmmssEnd) async {
    return await _stationHistoricalDataSource.getStationHistoricalBetweenDate(stationId, yyyymmddhhmmssStart, yyyymmddhhmmssEnd);
  }
}
