import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/weather_station.dart';
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

  Future<bool> createStation(WeatherStation weatherStation) async{
    bool succesfullCreation = false;
    try{
      final station = await stationRepository.createStation(weatherStation);
      _addStation(station);
      succesfullCreation = true;
    } on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message);
    } catch (e){
      state = state.copyWith(errorMessage: '$e');
    }
    return succesfullCreation;   
  }

  Future<bool> editStation(WeatherStation weatherStation) async{
    bool succesfullEdited = false;
    try{
      final stationUpdated = await stationRepository.editStation(weatherStation);
      _editStation(stationUpdated);
      succesfullEdited = true;
    } on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message);
    } catch (e){
      state = state.copyWith(errorMessage: '$e');
    }
    return succesfullEdited;   
  }

  Future getAllStation() async {
    if(state.isLoading) return;

    try{
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
    }on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message);
    } catch (e){
      state = state.copyWith(errorMessage: '$e');
    }
  }
  Future<bool> deleteStation(WeatherStation station) async{
    bool succesfullElimination= false;
    try{
       await stationRepository.deleteStation(station);
      _removeStation(station);
      succesfullElimination = true;
    } on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message);
    } catch (e){
      state = state.copyWith(errorMessage: '$e');
    }
    return succesfullElimination;   
  }

  WeatherStation getStationByIdInMemory(String id){
    return state.stations.where((element) => element.id == id).toList().first;
  }
  
  //No es el mismo objeto, hemos creado uno nuevo.
  _editStation(WeatherStation station){
    state = state.copyWith(
        stations: state.stations.map(
          (element) => ( element.id == station.id ) ? station : element,
        ).toList()
    );
  }

  _addStation(WeatherStation station){
    final List<WeatherStation> stations = state.stations;
    stations.add(station);
    state = state.copyWith(stations: stations);
  }
  _removeStation(WeatherStation station){
    final List<WeatherStation> stations = state.stations;
    stations.remove(station);
    state = state.copyWith(stations: stations);
  }
}

//Vamos a crear el estados.
class StationsState{
  final List<WeatherStation> stations;
  final bool isLoading;
  final String errorMessage;

  StationsState({
    this.stations = const[], 
    this.isLoading = false,
    this.errorMessage = ""
  });

  //Y creamos el método para "actualizar el estado"
  StationsState copyWith({
    List<WeatherStation>? stations,
    bool? isLoading,
    String? errorMessage,
  }) => StationsState(
    isLoading: isLoading ?? this.isLoading,
    stations: stations ?? this.stations,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}