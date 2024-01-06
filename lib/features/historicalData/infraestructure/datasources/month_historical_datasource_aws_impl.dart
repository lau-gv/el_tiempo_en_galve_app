import 'package:dio/dio.dart';
import 'package:el_tiempo_en_galve_app/config/constants/enviroment.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/datasources/month_historical_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_agroup_year.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/mappers/historical_data_month_mapper.dart';

import '../../../auth/infraestructure/errors/auth_errors.dart';

class MonthHistoricalDatasourceAwsImpl implements MonthHistoricalDataSource {
  late final Dio dio;
  final String accessToken;

  final String apiEndpoint = "/monthHistorical";

  MonthHistoricalDatasourceAwsImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Enviroment.historicalDataApi,
            headers: {
              //'Authorization': accessToken
              'x-api-key': Enviroment.historicalDataApikey
            }));

  @override
  Future<HistoricalAgroupYear> getHistoricalMonthOfAYear(String stationId, int yyyy) async{

    try {
      HistoricalAgroupYear historicalYear = HistoricalAgroupYear();
      final response = await dio
          .get('$apiEndpoint/year?stationId=$stationId&datadate=$yyyy');

      (response.data ?? []).forEach((historicalDataMonth) =>
          historicalYear.addHistoricalDataMonth(
              HistoricalDataMonthAWSMapper.fromJson(historicalDataMonth)));

      return historicalYear;
    } on DioError catch (e) {
      throw CustomError(message: e.response != null ? e.response!.data : "");
    } catch (e) {
      throw Exception();
    }
  }
}
