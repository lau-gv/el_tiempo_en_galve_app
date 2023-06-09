
import 'package:dio/dio.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/datasources/day_historical_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/mappers/historical_data_day_mapper.dart';

import '../../../../config/constants/enviroment.dart';
import '../../../auth/infraestructure/errors/auth_errors.dart';

class DayHistoricalDatasourceAwsImpl implements DayHistoricalDataSource {

  late final Dio dio;
  final String accessToken;

  final String apiEndpoint = "/dayHistorical";

  DayHistoricalDatasourceAwsImpl({required this.accessToken})
  : dio = Dio(BaseOptions(
    baseUrl: Enviroment.historicalDataApi,
    headers: {
      'Authorization' : accessToken
    }
  ));

  @override
  Future<Map<int, HistoricalDataDay>> getHistoricalDataDayOfAMonth(String stationId, int yyyymm) {
    // TODO: implement getHistoricalDataDayOfAMonth
    throw UnimplementedError();
  }

  @override
  Future<List<HistoricalDataDay>> getLast7HistoricalDataDays(String stationId, int yyyymmddStart, int yyyymmddEnd) {
    // TODO: implement getLast7HistoricalDataDays
    throw UnimplementedError();
  }

  @override
  Future<HistoricalDataDay> getTodayHistorical(String stationId, int yyyymmdd) async {
  
    try {
      final response = await dio.get('$apiEndpoint/day?stationId=$stationId&datadate=$yyyymmdd');
      return HistoricalDataDayAWSMapper.fromJson(response.data);
    }on DioError catch (e) {
      throw CustomError(message: e.message != null ? e.message! : "");
    } catch (e){
      throw Exception();
    }
  }
}
