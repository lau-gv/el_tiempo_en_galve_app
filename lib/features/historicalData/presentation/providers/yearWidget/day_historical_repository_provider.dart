
import 'package:el_tiempo_en_galve_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/month_historical_repository.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/datasources/month_historical_datasource_aws_impl.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/repositories/month_historical_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final monthHistoricalRepositoryProvider = Provider<MonthHistoricalRepository>((ref){

  final accessToken = ref.watch(authProvider).user?.token ?? "";

  return MonthHistoricalRepositoryImpl(
    historicalDataSource: MonthHistoricalDatasourceAwsImpl(accessToken: accessToken)
  );
});