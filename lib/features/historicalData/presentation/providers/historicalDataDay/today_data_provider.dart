import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:el_tiempo_en_galve_app/config/constants/enviroment.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/day_historical_repository.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/day_historical_repository_aws_provider.dart';


import '../../../../auth/infraestructure/errors/auth_errors.dart';


//Y ahora el provider
final todayHistoricalDataDayProvider = StateNotifierProvider<HistoricalDataDayNotifier, TodayHistoricalDataState>((ref) {
  //Recordar a nuestro provider que está escucharndo al token!!!
  final historicalDataDayRepository = ref.watch(dayHistoricalRepositoryProvider);
  return HistoricalDataDayNotifier(historicalDataDayRepository: historicalDataDayRepository);
});

//eL notifier
class HistoricalDataDayNotifier extends StateNotifier<TodayHistoricalDataState> {
  final DayHistoricalRepository historicalDataDayRepository;

  HistoricalDataDayNotifier({
    required this.historicalDataDayRepository
  }): super( TodayHistoricalDataState()){
    //Así ejecutamos na mas instanciarse esto.
    _getHistoricalDataDay();
    startRepeatingFunction();
  }

  void startRepeatingFunction() async {
    const Duration interval = Duration(minutes: 5);
     Timer.periodic(interval, (Timer timer) {
    // Llama a tu función aquí
      _getHistoricalDataDay();
    });
  }

  Future _getHistoricalDataDay() async{
    try{

      HistoricalDataDay historicalDataDay = await historicalDataDayRepository.getTodayHistorical(Enviroment.stationId, _getToday());  
      state = state.copyWith(historicalDataDay: historicalDataDay);
    } on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message);
    } catch (e){
      state = state.copyWith(errorMessage: '$e');
    }
  }

  int _getToday(){
    DateTime now = DateTime.now();
    String day = now.day < 10 ? "0${now.day}" : "${now.day}";
    String month = now.month < 10 ? "0${now.month}" : "${now.month}";
    return int.parse("${now.year}$month$day");
  }
}

//El estado.
class TodayHistoricalDataState{
  final HistoricalDataDay? historicalDataDay;
  final String errorMessage;

  TodayHistoricalDataState({
    this.historicalDataDay ,
    this.errorMessage = ""
  });

  TodayHistoricalDataState copyWith({
    HistoricalDataDay? historicalDataDay,
    String? errorMessage,
  }) => TodayHistoricalDataState(
    historicalDataDay : historicalDataDay ?? this.historicalDataDay,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}