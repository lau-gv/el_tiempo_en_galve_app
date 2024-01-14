import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/station_data.dart';


abstract class StationHistoricalDataRepository {
  Future<List<StationData>> getStationHistoricalBetweenDate(String stationId,  int yyyymmddhhmmssStart, int yyyymmddhhmmssEnd);
}
