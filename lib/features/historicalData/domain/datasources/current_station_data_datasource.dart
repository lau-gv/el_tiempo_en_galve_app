import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/current_station_data.dart';

import '../entities/historical_data_day.dart';

abstract class CurrentStationDataDatasource {
  Future<CurrentStationData> getCurrentStationData(String stationId);
}
