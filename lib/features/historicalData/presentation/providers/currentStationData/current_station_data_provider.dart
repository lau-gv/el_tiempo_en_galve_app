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
    startRepeatingFunction();
  }

  void startRepeatingFunction() async {
    const Duration interval = Duration(minutes: 5);
     Timer.periodic(interval, (Timer timer) {
    // Llama a tu función aquí
      _getCurrentStationData();
    });
  }

  Future _getCurrentStationData() async{
    try{
      CurrentStationData currentStationData = await currentStationDataRepository.getCurrentStationData(Enviroment.stationId);  
      state = state.copyWith(currentStationData: currentStationData, currentDate: _getDateTime());
    } on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message);
    } catch (e){
      state = state.copyWith(errorMessage: '$e');
    }
  }

  String _getDateTime(){
    DateTime now = DateTime.now();
    String day = now.day < 10 ? "0${now.day}" : "${now.day}";
    String month = now.month < 10 ? "0${now.month}" : "${now.month}";
    return "$day/$month/${now.year} ${now.hour}:${now.minute} h";
  }
}

//El estado.
class CurrentStationDataState{
  final CurrentStationData? currentStationData;
  final String errorMessage;
  final String currentDate;

  CurrentStationDataState({
    this.currentStationData ,
    this.errorMessage = "",
    this.currentDate = "",
  });

  CurrentStationDataState copyWith({
    CurrentStationData? currentStationData,
    String? errorMessage,
    String? currentDate,
  }) => CurrentStationDataState(
    currentStationData : currentStationData ?? this.currentStationData,
    errorMessage: errorMessage ?? this.errorMessage,
    currentDate: currentDate ?? this.currentDate,
  );
}