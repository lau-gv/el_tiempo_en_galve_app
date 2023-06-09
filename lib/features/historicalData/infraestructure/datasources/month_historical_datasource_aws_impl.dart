import 'package:dio/dio.dart';
import 'package:el_tiempo_en_galve_app/config/constants/enviroment.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/datasources/month_historical_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';

import '../../../auth/infraestructure/errors/auth_errors.dart';

class MonthHistoricalDatasourceAwsImpl implements MonthHistoricalDataSource {
  
  late final Dio dio;
  final String accessToken;


  final String apiEndpoint = "/monthHistorical";

  MonthHistoricalDatasourceAwsImpl({required this.accessToken})
  : dio = Dio(BaseOptions(
    baseUrl: Enviroment.historicalDataApi,
    headers: {
      'Authorization' : accessToken
    }
  ));

  @override
  Future<Map<int, HistoricalDataDay>> getHistoricalMonthOfAYear(String stationId, int yyyymmdd) async {
    try {
      final response = await dio.get('$apiEndpoint?stationId=$stationId&datadate=$yyyymmdd');
      /*final List<WeatherStation> stations = [];
      (response.data ?? []).forEach((station) => stations.add(StationMapper.weatherStationDTOToEntity(
        WeatherStationDTO.fromJson(station)
      )));*/
      
          throw UnimplementedError();
    }on DioError catch (e) {
      throw CustomError(message: e.message != null ? e.message! : "");
    } catch (e){
      throw Exception();
    }
  }
 
}
