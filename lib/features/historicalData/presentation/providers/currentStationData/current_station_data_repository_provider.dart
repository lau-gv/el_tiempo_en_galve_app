
import 'package:el_tiempo_en_galve_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/current_station_data_repository.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/datasources/current_station_data_datasource_aws_impl.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/repositories/current_station_data_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentStationDataRepositoryProvider = Provider<CurrentStationDataRepository>((ref){

  final accessToken = ref.watch(authProvider).user?.token ?? "";

  return CurrentStationDataRepositoryImpl(
    currentStationDataDataSource : CurrentStationDataDatasourceAwsImpl(
      accessToken: accessToken
    )
  );
});