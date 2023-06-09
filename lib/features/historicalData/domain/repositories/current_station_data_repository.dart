import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/current_station_data.dart';

abstract class CurrentStationDataRepository {
  Future<CurrentStationData> getCurrentStationData(String stationId);
}
