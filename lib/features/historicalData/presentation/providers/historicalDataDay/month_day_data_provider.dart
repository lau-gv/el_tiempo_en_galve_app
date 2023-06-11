import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_month.dart';
import 'package:el_tiempo_en_galve_app/config/constants/enviroment.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/day_historical_repository.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/day_historical_repository_provider.dart';




//Y ahora el provider
final monthHistoricalDataProvider = StateNotifierProvider<MonthHistoricalDataDayNotifier, MonthHistoricalDataState>((ref) {
  //Recordar a nuestro provider que está escucharndo al token!!!
  final historicalDataDayRepository = ref.watch(dayHistoricalRepositoryProvider);
  return MonthHistoricalDataDayNotifier(historicalDataDayRepository: historicalDataDayRepository);
});

//eL notifier
class MonthHistoricalDataDayNotifier extends StateNotifier<MonthHistoricalDataState> {
  final DayHistoricalRepository historicalDataDayRepository;

  MonthHistoricalDataDayNotifier({
    required this.historicalDataDayRepository
  }): super( MonthHistoricalDataState()){
    //Así ejecutamos na mas instanciarse esto.
    _getHistoricalDataDay(_getCurrentMonth());
  }

  Future _getHistoricalDataDay(int yyyymm) async{
    try{
      state = state.copyWith(isLoading: true);
      HistoricalMonth monthHistoricalDataDay = await historicalDataDayRepository.getHistoricalDataDayOfAMonth(Enviroment.stationId, yyyymm); 
      state = state.copyWith(monthHistoricalDataDay: monthHistoricalDataDay, isLoading: false);
    } on CustomError catch (e){
      print(e.message);
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e){
      print(e);
      state = state.copyWith(errorMessage: '$e', isLoading: false);
    }
  }

  int _getCurrentMonth(){
    DateTime now = DateTime.now();
    String month = now.month < 10 ? "0${now.month}" : "${now.month}";
    return int.parse("${now.year}$month");
  }

}

//El estado.
class MonthHistoricalDataState{
  final HistoricalMonth? monthHistoricalDataDay;
  final String errorMessage;
  final bool isLoading;

  MonthHistoricalDataState({
    this.monthHistoricalDataDay ,
    this.errorMessage = "",
    this.isLoading = false,
  });

  MonthHistoricalDataState copyWith({
    HistoricalMonth? monthHistoricalDataDay,
    String? errorMessage,
    bool? isLoading,
  }) => MonthHistoricalDataState(
    monthHistoricalDataDay : monthHistoricalDataDay ?? this.monthHistoricalDataDay,
    errorMessage: errorMessage ?? this.errorMessage,
    isLoading: isLoading ?? this.isLoading,
  );
}