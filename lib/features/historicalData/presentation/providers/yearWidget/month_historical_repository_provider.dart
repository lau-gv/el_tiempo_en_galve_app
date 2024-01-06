
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/month_historical_repository.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/datasources/month_historical_datasource_aws_impl.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/repositories/month_historical_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final monthHistoricalRepositoryProvider = Provider<MonthHistoricalRepository>((ref){

  return MonthHistoricalRepositoryImpl(
    historicalDataSource: MonthHistoricalDatasourceAwsImpl()
  );
});