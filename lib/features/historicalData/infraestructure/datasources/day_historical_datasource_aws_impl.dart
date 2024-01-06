
import 'package:dio/dio.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/datasources/day_historical_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_agroup_month.dart';
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
      //'Authorization' : accessToken
      'x-api-key': Enviroment.historicalDataApikey
    }
  ));

  @override
  Future<HistoricalAgroupMonth> getHistoricalDataDayOfAMonth(String stationId, int yyyymm) async {
    try {
      HistoricalAgroupMonth historicalMonth = HistoricalAgroupMonth();
      final response = await dio.get('$apiEndpoint/month?stationId=$stationId&datadate=$yyyymm');
    
      (response.data ?? []).forEach((historicalDataDay) => historicalMonth.addHistoricalDataDay(
        HistoricalDataDayAWSMapper.fromJson(historicalDataDay)));

      return historicalMonth;

    }on DioError catch (e) {
      throw CustomError(message: e.response != null ? e.response!.data : "");
    } catch (e){
      throw Exception();
    }        
  }

  @override
  Future<List<HistoricalDataDay>> getLastDataBetween(String stationId, int yyyymmddStart, int yyyymmddEnd) async{
    try {
      final response = await dio.get('$apiEndpoint/between?stationId=$stationId&startDay=$yyyymmddStart&endDay=$yyyymmddEnd');
      final List<HistoricalDataDay> historicalDataDays = [];

      (response.data ?? []).forEach((historicalDataDay) => historicalDataDays.add(
        HistoricalDataDayAWSMapper.fromJson(historicalDataDay)));

      return historicalDataDays;
    }on DioError catch (e) {
      throw CustomError(message: e.response != null ? e.response!.data : "");
    } catch (e){
      throw Exception();
    }    
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
