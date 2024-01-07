import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/station_data.dart';


abstract class CurrentStationDataDatasource {
  Future<StationData> getCurrentStationData(String stationId);
}
