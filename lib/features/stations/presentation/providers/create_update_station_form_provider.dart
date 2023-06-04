import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/useCases/create_station_manager.dart';
import 'package:el_tiempo_en_galve_app/features/stations/domain/entities/weather_station.dart';
import 'package:el_tiempo_en_galve_app/features/stations/presentation/providers/inputs/base_input.dart';
import 'package:el_tiempo_en_galve_app/features/stations/presentation/providers/stations_provider.dart';



final createStationFormProvider = StateNotifierProvider.autoDispose<StationFormNotifier, CreateOrEditStationFormState>((ref) {
  //Recordar a nuestro provider que está escucharndo al token!!!
  final createStation = ref.watch(stationsProvider.notifier).createStation;
  return StationFormNotifier(onSubmitCallback: createStation, createStationManager: CreateStationManager());
});

final updateStationFormProvider = StateNotifierProvider.autoDispose.family<StationFormNotifier, CreateOrEditStationFormState, String>((ref, stationId) {
  //Recordar a nuestro provider que está escucharndo al token!!!
  final editStation = ref.watch(stationsProvider.notifier).editStation;
  final station = ref.read(stationsProvider.notifier).getStationByIdInMemory(stationId);

  return StationFormNotifier(
    station: station,
    onSubmitCallback: editStation, 
    createStationManager: CreateStationManager());
});

class StationFormNotifier extends StateNotifier<CreateOrEditStationFormState> {
  final Future<bool> Function(WeatherStation) onSubmitCallback;
  final CreateStationManager createStationManager;

  StationFormNotifier({
    WeatherStation? station,
    required this.onSubmitCallback,
    required this.createStationManager
  }): super(
    station == null 
    ? CreateOrEditStationFormState()
    : CreateOrEditStationFormState(
      station: station,
      stationType: station.stationType,
      stationMac: station.stationType == StationType.ecowitt ? BaseInput.dirty(station.key) : null,
      stationName: BaseInput.dirty(station.name),
      stationLocalization: BaseInput.dirty(station.location),
    )       
  );

  changeStationTypeSelected(StationType stationTypeChange){
    
    stationTypeChange == StationType.ecowitt 
    ? state = state.copyWith(stationType: stationTypeChange, stationMac: state.stationMac ?? const BaseInput.pure())
    : state = state.copyWith(stationType: stationTypeChange, stationMac: null);
  }
  
  onNameChange(String value){
    
    final newName = BaseInput.dirty(value);
    state = state.copyWith(
      stationName: newName, isValid: Formz.validate([
        newName, 
        state.stationLocalization, 
        if(state.stationMac != null) state.stationMac!
        ])
    );
  }
  onLocationChange(String value){
    final newLocation = BaseInput.dirty(value);
    state = state.copyWith(
      stationLocalization: newLocation, isValid: Formz.validate([
        newLocation, 
        state.stationName, 
        if(state.stationMac != null) state.stationMac!
        ])
    );
  }
  onMacChange(String value){
    if(state.stationType != StationType.ecowitt) return;
    final newMac = BaseInput.dirty(value);
    state = state.copyWith(
      stationMac: newMac, isValid: Formz.validate([
        newMac, 
        state.stationName, 
        state.stationLocalization
        ])
    );
  }
  Future<bool> onFormSubmit() async {
    _touchEveryField();
    if(!state.isValid) return false;
    return await onSubmitCallback(_createOrUpdate());
  }

  WeatherStation _createOrUpdate(){
    return state.station == null
      ? _createStationtype()
      : _updateStation();
  }


  WeatherStation _createStationtype(){
    return createStationManager.createNewStation(
      state.stationType,
      state.stationName.value,
      state.stationLocalization.value,
      state.stationMac != null ? state.stationMac!.value : null,
      null,
      null,
      null,
    );
  }
  WeatherStation _updateStation(){
    return createStationManager.createNewStation(
      state.stationType,
      state.stationName.value,
      state.stationLocalization.value,
      state.stationMac != null ? state.stationMac!.value : state.station!.key,
      state.station!.id,
      state.station!.auth,
      state.station!.userId,
    );
  }
  

  
  _touchEveryField(){
    final name = BaseInput.dirty(state.stationName.value);
    final localization = BaseInput.dirty(state.stationLocalization.value);
    final mac = state.stationMac == null ? null : BaseInput.dirty(state.stationMac!.value);

    state = state.copyWith(
      isLoading: true,
      stationName: name,
      stationLocalization: localization,
      stationMac: mac,
      isValid: Formz.validate([
        name, localization,
        if(mac != null) mac
      ])
    );
  }
}

class CreateOrEditStationFormState{
  final WeatherStation? station;
  final BaseInput stationName;
  final BaseInput stationLocalization;
  final StationType stationType;
  final BaseInput? stationMac;
  final bool isValid;
  final bool isLoading;

  CreateOrEditStationFormState({
    this.station,
    this.stationName = const BaseInput.pure(), 
    this.stationLocalization = const BaseInput.pure(), 
    this.stationType = StationType.ecowitt, 
    this.stationMac = const BaseInput.pure(), 
    this.isValid = false,
    this.isLoading = false});

  //Y creamos el método para "actualizar el estado"
  CreateOrEditStationFormState copyWith({
    WeatherStation? station,
    BaseInput? stationName,
    BaseInput? stationLocalization,
    StationType? stationType,
    BaseInput? stationMac,
    WeatherStation? weatherStation,
    bool? isValid,
    bool? isLoading,
  }) => CreateOrEditStationFormState(
    station:  station ?? this.station,
    stationName:  stationName ?? this.stationName,
    stationLocalization:  stationLocalization ?? this.stationLocalization,
    stationType:  stationType ?? this.stationType,
    stationMac:  stationMac,
    isValid: isValid ?? this.isValid,
    isLoading: isLoading ?? this.isLoading,
  );
}