import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:el_tiempo_en_galve_app/config/constants/enviroment.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/day_historical_repository.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/day_historical_repository_provider.dart';


import '../../../../auth/infraestructure/errors/auth_errors.dart';


//Y ahora el provider
final weekHistoricalDataProvider = StateNotifierProvider<WeekHistoricalDataDayNotifier, WeekHistoricalDataState>((ref) {
  //Recordar a nuestro provider que está escucharndo al token!!!
  final historicalDataDayRepository = ref.watch(dayHistoricalRepositoryProvider);
  return WeekHistoricalDataDayNotifier(historicalDataDayRepository: historicalDataDayRepository);
});

//eL notifier
class WeekHistoricalDataDayNotifier extends StateNotifier<WeekHistoricalDataState> {
  final DayHistoricalRepository historicalDataDayRepository;

  WeekHistoricalDataDayNotifier({
    required this.historicalDataDayRepository
  }): super( WeekHistoricalDataState()){
    //Así ejecutamos na mas instanciarse esto.
    _getHistoricalDataDay();
  }

  //int yyyymmddStart,
  //int yyyymmddEnd,
  Future _getHistoricalDataDay() async{
    try{
      state = state.copyWith(isLoading: false);
      List<HistoricalDataDay>? weekHistoricalDataDay = await historicalDataDayRepository.getLastDataBetween(Enviroment.stationId, _getStartDay(), _getEndDay()); 
      state = state.copyWith(weekHistoricalDataDay: weekHistoricalDataDay, isLoading: false);
    } on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e){
      state = state.copyWith(errorMessage: '$e', isLoading: false);
    }
  }

  int _getEndDay(){
    DateTime now = DateTime.now().subtract(const Duration(days: 1));
    //Restamos un día a hoy porque hoy lo vamos a pasar para que se actualice.
    String day = now.day < 10 ? "0${now.day}" : "${now.day}";
    String month = now.month < 10 ? "0${now.month}" : "${now.month}";
    return int.parse("${now.year}$month$day");
  }
    int _getStartDay(){
    DateTime now = DateTime.now().subtract(const Duration(days: 6));
    String day = now.day < 10 ? "0${now.day}" : "${now.day}";
    String month = now.month < 10 ? "0${now.month}" : "${now.month}";
    return int.parse("${now.year}$month$day");
  }
  

}

//El estado.
class WeekHistoricalDataState{
  final List<HistoricalDataDay>? weekHistoricalDataDay;
  final String errorMessage;
  final bool isLoading;

  WeekHistoricalDataState({
    this.weekHistoricalDataDay ,
    this.errorMessage = "",
    this.isLoading = false,
  });

  WeekHistoricalDataState copyWith({
    List<HistoricalDataDay>? weekHistoricalDataDay,
    String? errorMessage,
    bool? isLoading,
  }) => WeekHistoricalDataState(
    weekHistoricalDataDay : weekHistoricalDataDay ?? this.weekHistoricalDataDay,
    errorMessage: errorMessage ?? this.errorMessage,
    isLoading: isLoading ?? this.isLoading,
  );
}