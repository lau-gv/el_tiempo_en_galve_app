import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/station_data.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/currentStationData/current_station_data_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/all_today_station_data_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/today_data_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/screens/detailCurrentData/temperature_day_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../shared/widgets/widgets.dart';

class DetailCurrentData extends ConsumerWidget {
  
  static const name = 'detail_current_data_screen';
  
  const DetailCurrentData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final stationCurrentDataProvider = ref.watch(currentStationDataProvider);
    final allStationDataProvider = ref.watch(allTodayStationDataRepositoryProvider);
    //final todayMaxMinData = ref.watch(todayHistoricalDataDayProvider).historicalDataDay;
    final stationCurrentData = stationCurrentDataProvider.currentStationData;
    final alltodayStationCurrentData = allStationDataProvider.stationDataList;
    
    return BackgroundGradient(
      widget: Scaffold(
        appBar: AppBar(
          title: const Text("Condiciones hoy"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              //...temperatureDaySection(Theme.of(context), alltodayStationCurrentData ?? []),
              _CardHistoricalDayData(
                stationDataList: alltodayStationCurrentData ?? [], 
                stationCurrentData: stationCurrentData,
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _CardHistoricalDayData extends StatelessWidget {
  final List<StationData> stationDataList;
  final StationData? stationCurrentData;

  const _CardHistoricalDayData({required this.stationDataList, required this.stationCurrentData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...temperatureDaySection(
            theme, 
            stationDataList,
          )
        ],
      ),
    ));
  }
}