import 'package:el_tiempo_en_galve_app/config/constants/enviroment.dart';
import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_agroup_month.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/month_enum.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/day_historical_repository.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/day_historical_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final monthHistoricalDataProvider = StateNotifierProvider<MonthHistoricalDataNotifier, MonthWidgetState>((ref) {
  //Recordar a nuestro provider que está escucharndo al token!!!
  final historicalDataDayRepository = ref.watch(dayHistoricalRepositoryProvider);
  return MonthHistoricalDataNotifier(historicalDataDayRepository: historicalDataDayRepository);
});


class MonthHistoricalDataNotifier extends StateNotifier<MonthWidgetState> {
  final DayHistoricalRepository historicalDataDayRepository;

  MonthHistoricalDataNotifier({
    required this.historicalDataDayRepository
  }): super( MonthWidgetState()){
    _getNewHistoricalDataDay(_getDataDate());
    //Así ejecutamos na mas instanciarse esto.  
  }  

  onMonthChange(MonthEnum monthEnum){
    state = state.copyWith(
      monthEnum: monthEnum
    );
  }
  onYearChange(int year){
    state = state.copyWith(
      year: year
    );
  }
  Future onSearch()async {
    _getNewHistoricalDataDay(_getDataDate());
  }
  
  Future _getNewHistoricalDataDay(int yyyymm) async{
    try{
      state = state.copyWith(isLoading: true);
      Map<int, HistoricalAgroupMonth> historicalMonths = state.historicalMonths;
      HistoricalAgroupMonth? monthHistoricalDataDay = historicalMonths[yyyymm];

      if(historicalMonths.isNotEmpty && monthHistoricalDataDay != null){
        state = state.copyWith(visibleHistoricalMonth: monthHistoricalDataDay, isLoading: false);
      }else{
        monthHistoricalDataDay = await historicalDataDayRepository.getHistoricalDataDayOfAMonth(Enviroment.stationId, yyyymm); 
        historicalMonths[yyyymm] = monthHistoricalDataDay;
        state = state.copyWith(visibleHistoricalMonth: monthHistoricalDataDay, historicalMonths: historicalMonths, isLoading: false);
      }      
    } on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e){

      state = state.copyWith(errorMessage: '$e', isLoading: false);
    }
  }

  int _getDataDate(){
    int year = state.year;
    int month = state.monthEnum.index +1;
    String monthString = month < 10 ? "0$month" : "$month";
    return int.parse("$year$monthString");
  }

}
//Primero definimos el estado:
class MonthWidgetState {
  final Map<int, HistoricalAgroupMonth> historicalMonths;
  final HistoricalAgroupMonth? visibleHistoricalMonth;
  final MonthEnum monthEnum;
  final int year;
  final String errorMessage;
  final bool isLoading;

  MonthWidgetState({
    Map<int, HistoricalAgroupMonth>? historicalMonths,
    this.visibleHistoricalMonth,
    MonthEnum? monthEnum,
    int? year,
    this.errorMessage = '',
    this.isLoading = false,
  })  : historicalMonths = historicalMonths ?? <int, HistoricalAgroupMonth>{},
        monthEnum = monthEnum ?? MonthEnum.values[DateTime.now().month -1],
        year = year ?? DateTime.now().year;

  MonthWidgetState copyWith ({
  Map<int, HistoricalAgroupMonth>? historicalMonths,
  HistoricalAgroupMonth? visibleHistoricalMonth,
  MonthEnum? monthEnum,
  int? year,
  String? errorMessage,
  bool? isLoading,
  }) => MonthWidgetState(
    historicalMonths: historicalMonths ?? this.historicalMonths,
    visibleHistoricalMonth: visibleHistoricalMonth ?? this.visibleHistoricalMonth,
    monthEnum: monthEnum ?? this.monthEnum,
    year: year ?? this.year,
    errorMessage: errorMessage ?? this.errorMessage,
    isLoading:  isLoading ?? this.isLoading,
  );
}
