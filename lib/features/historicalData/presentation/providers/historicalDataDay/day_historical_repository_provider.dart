import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/day_historical_repository.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/datasources/day_historical_datasource_aws_impl.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/repositories/day_historical_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dayHistoricalRepositoryProvider = Provider<DayHistoricalRepository>((ref){

  //final accessToken = ref.watch(authProvider).user?.token ?? "";

  return DayHistoricalRepositoryImpl(
    historicalDataSource: DayHistoricalDatasourceAwsImpl(
      //accessToken: accessToken
    )
  );
});