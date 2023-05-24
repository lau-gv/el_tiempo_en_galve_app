import 'package:el_tiempo_en_galve_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/repositories/station_repository.dart';
import 'package:el_tiempo_en_galve_app/features/stations/infraestructure/datasource/station_datasource_impl_apiAWS.dart';
import 'package:el_tiempo_en_galve_app/features/stations/infraestructure/repository/station_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//Esta es una de las formas que tenemos de comunicar dos estados. Además, estamos 
//Pasando los valores del accestoken y del userId de forma que, cuando cambien, también serán 
//notificados a aquí. Esto me permite además que luego, cuando haga algo para actualizar el token
//cada x tiempo, que automáticamente se utilice el token adecuado. porque 
//tenemos un observador!!!!!
final stationRepositoryProvider = Provider<StationRepository>((ref){

  final accessToken = ref.watch(authProvider).user?.token ?? '';
  final userId = ref.watch(authProvider).user?.id ?? '';

  final stationRepository = StationRepositoryImpl(
    StationDatasourceImplApiAWS(accessToken: accessToken, userId: userId)
  );

  return stationRepository;

});