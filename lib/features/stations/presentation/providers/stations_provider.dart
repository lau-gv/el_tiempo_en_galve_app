import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/station.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/repositories/station_repository.dart';
import 'package:el_tiempo_en_galve_app/features/stations/presentation/providers/station_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//Recordar.
//Necesitamos un provider para notificar los cambios de estado del listado de estacione
//Necesitamos manejar un estado para poder mantenerlo en memoria
//Y necesitaremos un notifier para hacer cosas y manejar el estado

//Vamos a crear el provier.
final stationsProvider = StateNotifierProvider<StationsNotifier, StationsState>((ref) {
  //Recordar a nuestro provider que está escucharndo al token!!!
  final stationRepository = ref.watch(stationRepositoryProvider);
  return StationsNotifier(stationRepository: stationRepository);
});

//Vamos a crear al """manejador del estado"""
class StationsNotifier extends StateNotifier<StationsState> {
  final StationRepository stationRepository;

  StationsNotifier({
    required this.stationRepository
  }): super( StationsState()){
    //Así ejecutamos na mas instanciarse esto.
    getAllStation();
  }

  Future getAllStation() async {
    if(state.isLoading) return;

    final stations = await stationRepository.getStationsByUser();
    if(stations.isEmpty) {
      state = state.copyWith(
        isLoading: false
      );
    }

    state = state.copyWith(
      isLoading: false,
      stations: stations
    );
  }
}

//Vamos a crear el estados.
class StationsState{
  final List<WeatherStation> stations;
  final bool isLoading;

  StationsState({this.stations = const[], this.isLoading = false});

  //Y creamos el método para "actualizar el estado"
  StationsState copyWith({
    List<WeatherStation>? stations,
    bool? isLoading,
  }) => StationsState(
    isLoading: isLoading ?? this.isLoading,
    stations: stations ?? this.stations
  );
}