import 'package:el_tiempo_en_galve_app/features/historicalData/domain/datasources/current_station_data_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/station_data.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/current_station_data_repository.dart';

class CurrentStationDataRepositoryImpl implements CurrentStationDataRepository {

  final CurrentStationDataDatasource _currentStationDataDataSource;

  CurrentStationDataRepositoryImpl({currentStationDataDataSource}): _currentStationDataDataSource = currentStationDataDataSource;
  @override
  Future<StationData> getCurrentStationData(String stationId) async {
    return await _currentStationDataDataSource.getCurrentStationData(stationId);
  }

 
}
