import 'dart:async';

import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/currentStationData/current_station_data_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/current_station_data.dart';
import 'package:el_tiempo_en_galve_app/config/config.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/current_station_data_repository.dart';

//Y ahora el provider
final currentStationDataProvider = StateNotifierProvider<CurrentStationDataNotifier, CurrentStationDataState>((ref) {
  //Recordar a nuestro provider que está escucharndo al token!!!
  final currentStationDataRepository = ref.watch(currentStationDataRepositoryProvider);
  return CurrentStationDataNotifier(currentStationDataRepository: currentStationDataRepository);
});

//eL notifier
class CurrentStationDataNotifier extends StateNotifier<CurrentStationDataState> {
  final CurrentStationDataRepository currentStationDataRepository;

  CurrentStationDataNotifier({
    required this.currentStationDataRepository
  }): super( CurrentStationDataState()){
    //Así ejecutamos na mas instanciarse esto.
    _getCurrentStationData();
    _startRepeatingGetStationData();
    _startRepeatingUpdateTime();
  }

  void _startRepeatingGetStationData() async {
    const Duration interval = Duration(minutes: 5);
     Timer.periodic(interval, (Timer timer) {
    // Llama a tu función aquí
      _getCurrentStationData();
    });
  }
  void _startRepeatingUpdateTime() {
    const Duration interval = Duration(minutes: 1);
     Timer.periodic(interval, (Timer timer) {
    // Llama a tu función aquí
      state = state.copyWith(currentDate: DateTime.now(), currentDateString: _getDateTime());
    });
  }

  Future _getCurrentStationData() async{
    try{
      state = state.copyWith(isLoading: true);
      CurrentStationData currentStationData = await currentStationDataRepository.getCurrentStationData(Enviroment.stationId);  
      state = state.copyWith(
        currentStationData: currentStationData, 
        currentDate: DateTime.now(), 
        currentDateString: _getDateTime(),
        isLoading: false,
      );
    } on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e){
      state = state.copyWith(errorMessage: '$e', isLoading: false);
    }
  }

  String _getDateTime(){
    DateTime now = DateTime.now();
    String day = now.day < 10 ? "0${now.day}" : "${now.day}";
    String month = now.month < 10 ? "0${now.month}" : "${now.month}";
    String hour = now.hour < 10 ? "0${now.hour}" : "${now.hour}";
    String minute = now.minute < 10 ? "0${now.minute}" : "${now.minute}";
    return "$day/$month/${now.year}  $hour:$minute h";
  }
}

//El estado.
class CurrentStationDataState{
  final CurrentStationData? currentStationData;
  final String errorMessage;
  final String currentDateString;
  final DateTime? currentDate;
  final bool isLoading;
  

  CurrentStationDataState({
    this.currentStationData ,
    this.errorMessage = "",
    this.currentDateString = "",
    this.currentDate,
    this.isLoading = false,
  });

  CurrentStationDataState copyWith({
    CurrentStationData? currentStationData,
    String? errorMessage,
    String? currentDateString,
    DateTime? currentDate,
    bool? isLoading,
  }) => CurrentStationDataState(
    currentStationData : currentStationData ?? this.currentStationData,
    errorMessage: errorMessage ?? this.errorMessage,
    currentDateString: currentDateString ?? this.currentDateString,
    currentDate: currentDate ?? this.currentDate,
    isLoading: isLoading ?? this.isLoading,
  );
}