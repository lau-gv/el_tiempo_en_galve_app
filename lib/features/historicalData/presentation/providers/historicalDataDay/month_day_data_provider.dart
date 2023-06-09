import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:el_tiempo_en_galve_app/config/constants/enviroment.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/day_historical_repository.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/day_historical_repository_aws_provider.dart';


import '../../../../auth/infraestructure/errors/auth_errors.dart';


//Y ahora el provider
final currentStationDataProvider = StateNotifierProvider<HistoricalDataDayNotifier, TodayHistoricalDataState>((ref) {
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
    _getHistoricalDataDay(_getCurrentMonth());
  }

  Future _getHistoricalDataDay(int yyyymm) async{
    try{
      Map<int, HistoricalDataDay>? monthHistoricalDataDay = await historicalDataDayRepository.getHistoricalDataDayOfAMonth(Enviroment.stationId, yyyymm); 
      state = state.copyWith(monthHistoricalDataDay: monthHistoricalDataDay);
    } on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message);
    } catch (e){
      state = state.copyWith(errorMessage: '$e');
    }
  }

  int _getCurrentMonth(){
    DateTime now = DateTime.now();
    String month = now.month < 10 ? "0${now.month}" : "${now.month}";
    return int.parse("${now.year}$month");
  }

}

//El estado.
class TodayHistoricalDataState{
  final Map<int, HistoricalDataDay>? monthHistoricalDataDay;
  final String errorMessage;

  TodayHistoricalDataState({
    this.monthHistoricalDataDay ,
    this.errorMessage = ""
  });

  TodayHistoricalDataState copyWith({
    Map<int, HistoricalDataDay>? monthHistoricalDataDay,
    String? errorMessage,
  }) => TodayHistoricalDataState(
    monthHistoricalDataDay : monthHistoricalDataDay ?? this.monthHistoricalDataDay,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}