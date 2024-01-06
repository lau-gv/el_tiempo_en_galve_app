import 'package:el_tiempo_en_galve_app/config/constants/enviroment.dart';
import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/errors/auth_errors.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_agroup_year.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/repositories/month_historical_repository.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/yearWidget/month_historical_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final yearHistoricalDataProvider = StateNotifierProvider<YearHistoricalDataNotifier, YearWidgetState>((ref) {
  //Recordar a nuestro provider que está escucharndo al token!!!
  final historicalDataDayRepository = ref.watch(monthHistoricalRepositoryProvider);
  return YearHistoricalDataNotifier(monthHHistoricalRepository: historicalDataDayRepository);
});


class YearHistoricalDataNotifier extends StateNotifier<YearWidgetState> {
  final MonthHistoricalRepository monthHHistoricalRepository;

  YearHistoricalDataNotifier({
    required this.monthHHistoricalRepository
  }): super( YearWidgetState()){
    _getNewHistoricalDataMonth(_getDataDate());
    //Así ejecutamos na mas instanciarse esto.  
  }  


  onYearChange(int year){
    state = state.copyWith(
      year: year
    );
  }
  Future onSearch()async {
    _getNewHistoricalDataMonth(_getDataDate());
  }
  
  Future _getNewHistoricalDataMonth(int yyyy) async{
    try{
      state = state.copyWith(isLoading: true);
      Map<int, HistoricalAgroupYear> historicalYears = state.historicalYears;
      HistoricalAgroupYear? historicalYearDataMonth = historicalYears[yyyy];

      if(historicalYears.isNotEmpty && historicalYearDataMonth != null){
        state = state.copyWith(visibleHistoricalYear: historicalYearDataMonth, isLoading: false);
      }else{
        historicalYearDataMonth = await monthHHistoricalRepository.getHistoricalMonthOfAYear(Enviroment.stationId, yyyy); 
        historicalYears[yyyy] = historicalYearDataMonth;
        state = state.copyWith(visibleHistoricalYear: historicalYearDataMonth, historicalYears: historicalYears, isLoading: false);
      }      
    } on CustomError catch (e){
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e){

      state = state.copyWith(errorMessage: '$e', isLoading: false);
    }
  }

  int _getDataDate(){
    int year = state.year;
    return int.parse("$year");
  }

}
//Primero definimos el estado:
class YearWidgetState {
  final Map<int, HistoricalAgroupYear> historicalYears;
  final HistoricalAgroupYear? visibleHistoricalYear;
  final int year;
  final String errorMessage;
  final bool isLoading;

  YearWidgetState({
    Map<int, HistoricalAgroupYear>? historicalYears,
    this.visibleHistoricalYear,
    int? year,
    this.errorMessage = '',
    this.isLoading = false,
  })  : historicalYears = historicalYears ?? <int, HistoricalAgroupYear>{},
        year = year ?? DateTime.now().year;

  YearWidgetState copyWith ({
  Map<int, HistoricalAgroupYear>? historicalYears,
  HistoricalAgroupYear? visibleHistoricalYear,
  int? year,
  String? errorMessage,
  bool? isLoading,
  }) => YearWidgetState(
    historicalYears: historicalYears ?? this.historicalYears,
    visibleHistoricalYear: visibleHistoricalYear ?? this.visibleHistoricalYear,
    year: year ?? this.year,
    errorMessage: errorMessage ?? this.errorMessage,
    isLoading:  isLoading ?? this.isLoading,
  );
}
