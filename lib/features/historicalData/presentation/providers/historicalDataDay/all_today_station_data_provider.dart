import 'dart:async';

import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/station_data.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/datasources/station_historical_data_datasource_aws_impl.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/infraestructure/repositories/station_historical_data_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:el_tiempo_en_galve_app/config/constants/enviroment.dart';



//Y ahora el provider
final allTodayStationDataRepositoryProvider = StateNotifierProvider<AllTodayStationDataNotifier, AllTodayStationDataState>((ref) {
  
    StationHistoricalDataRepositoryImpl stationHistoricalDataRepositoryImpl = StationHistoricalDataRepositoryImpl(
      stationHistoricalDataSource: CurrentStationHistoricalDataDatasourceAwsImpl()
    );
  return AllTodayStationDataNotifier(historicalDataDayRepository: stationHistoricalDataRepositoryImpl);
});

//eL notifier
class AllTodayStationDataNotifier extends StateNotifier<AllTodayStationDataState> {
  
  final StationHistoricalDataRepositoryImpl historicalDataDayRepository;

  AllTodayStationDataNotifier({
    required this.historicalDataDayRepository
  }): super( AllTodayStationDataState()){
    //Así ejecutamos na mas instanciarse esto.
    getAllStationDataBetween();
    startRepeatingFunction();
  }

  void startRepeatingFunction() async {
    const Duration interval = Duration(minutes: 5);
     Timer.periodic(interval, (Timer timer) {
    // Llama a tu función aquí
      getAllStationDataBetween();
    });
  }

  Future getAllStationDataBetween() async{

    try{
      state = state.copyWith(isLoading: true);
      List<StationData> stationHistoricalDataList = await historicalDataDayRepository.getStationHistoricalBetweenDate(
        Enviroment.stationId, 
        _getTodayStartTime(), 
        _getTodayCurrentTime());

      //HistoricalDataDay historicalDataDay = await historicalDataDayRepository.getTodayHistorical(Enviroment.stationId, _getToday());  
      state = state.copyWith(stationDataList: stationHistoricalDataList, isLoading: false);
    } catch (e){
      state = state.copyWith(errorMessage: '$e' ,isLoading: false);
    }
  }

  int _getTodayStartTime(){
    DateTime now = DateTime.now();
    String day = now.day < 10 ? "0${now.day}" : "${now.day}";
    String month = now.month < 10 ? "0${now.month}" : "${now.month}";
    String initTime = "000000";
    return int.parse("${now.year}$month$day$initTime");
  }
  int _getTodayCurrentTime(){
    DateTime now = DateTime.now();
    String day = now.day < 10 ? "0${now.day}" : "${now.day}";
    String month = now.month < 10 ? "0${now.month}" : "${now.month}";
    String hour = now.hour < 10 ? "0${now.hour}" : "${now.hour}";
    String minute = now.minute < 10 ? "0${now.minute}" : "${now.minute}";
    String seconds = now.second < 10 ? "0${now.second}" : "${now.second}";
    
    return int.parse("${now.year}$month$day$hour$minute$seconds");
  }
}

//El estado.
class AllTodayStationDataState{
  final List<StationData>? stationDataList;
  final String errorMessage;
  final bool isLoading;


  AllTodayStationDataState({
    this.stationDataList,
    this.errorMessage = "",
    this.isLoading = false,
  });

  AllTodayStationDataState copyWith({
    List<StationData>? stationDataList,
    String? errorMessage,
    bool? isLoading,
  }) => AllTodayStationDataState(
    stationDataList : stationDataList ?? this.stationDataList,
    errorMessage: errorMessage ?? this.errorMessage,
    isLoading: isLoading ?? this.isLoading,
  );
}