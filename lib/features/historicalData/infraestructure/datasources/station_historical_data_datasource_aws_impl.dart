import 'package:dio/dio.dart';
import 'package:el_tiempo_en_galve_app/config/constants/enviroment.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/datasources/station_historical_data_datasource.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/station_data.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/mappers/current_station_data_mapper.dart';

import '../../../auth/infraestructure/errors/auth_errors.dart';


class CurrentStationDataDatasourceAwsImpl implements StationDataDatasource {
  
  late final Dio dio;

  final String apiEndpoint = "/stationHistorical";

  CurrentStationDataDatasourceAwsImpl()
  : dio = Dio(BaseOptions(
    baseUrl: Enviroment.historicalDataApi,
    headers: {
      //'Authorization' : accessToken
      'x-api-key': Enviroment.historicalDataApikey
    }
  ));

  @override
  Future<StationData> getStationHistoricalBetweenDate(String stationId, int yyyymmddhhmmssStart, int yyyymmddhhmmssEnd) async {
    try {
      final response = await dio.get('$apiEndpoint/between?stationId=$stationId&startDayTime=$yyyymmddhhmmssStart&endDayTime=$yyyymmddhhmmssEnd');
      return CurrentStationDataAWSMapper.fromJson(response.data);

    // ignore: deprecated_member_use
    }on DioError catch (e) {
      //En realidad esto no es necesario xD pero es que lo dejo así pq sí.
      throw CustomError(message: e.message != null ? e.message! : "");
    } catch (e){
      throw Exception();
    }
  }
}
