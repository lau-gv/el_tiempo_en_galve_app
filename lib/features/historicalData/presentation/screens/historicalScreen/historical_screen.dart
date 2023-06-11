import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_month.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/month_day_data_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/screens/historicalScreen/rain_month_section.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/screens/historicalScreen/temperature_month_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/widgets.dart';

class HistoricalScreen extends ConsumerWidget {
  
  static const name = 'historical_screen';
  
  const HistoricalScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    
    final monthDataProvider = ref.watch(monthHistoricalDataProvider);

    return BackgroundGradient(
      widget: monthDataProvider.isLoading 
      ? const Center(child: CircularProgressIndicator())
      : HistoricalDataWidget(monthDataProvider: monthDataProvider,),
    );
  }
}

class HistoricalDataWidget extends StatelessWidget {
  final MonthHistoricalDataState monthDataProvider;

  const HistoricalDataWidget({
    required this.monthDataProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Historico de datos"),
          bottom: const TabBar(
            tabs: [
            Tab(text: "MES",),
            Tab(text: "AÑO",)
          ]
          ),
        ),
        body: TabBarView(
          children: [              
            const SingleChildScrollView(child: _MonthHistoricalDataWidget(),),
            SingleChildScrollView(child: YearHistoricalDataWidget(monthDataProvider: monthDataProvider),),
          ],
        ),
      ),
    );
  }
}


class YearHistoricalDataWidget extends StatelessWidget {
  const YearHistoricalDataWidget({
    required this.monthDataProvider,
    super.key
  });

  final MonthHistoricalDataState monthDataProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardHistoricalMonthData(historicalMonth: monthDataProvider.monthHistoricalDataDay!, 
          childrens: rainMonthSection),
          const SizedBox(height: 10),
        _CardHistoricalMonthData(historicalMonth: monthDataProvider.monthHistoricalDataDay!, 
          childrens: temperatureMonthSection),
          const SizedBox(height: 10),
      ]
    );
  }
}

class _MonthHistoricalDataWidget extends ConsumerWidget {
  const _MonthHistoricalDataWidget({
    super.key
  });

  @override
  Widget build(BuildContext context, ref) {
    
    final monthDataProvider = ref.watch(monthHistoricalDataProvider);

    return Column(
      children: [
        _CardHistoricalMonthData(historicalMonth: monthDataProvider.monthHistoricalDataDay!, 
          childrens: rainMonthSection),
          const SizedBox(height: 10),
        _CardHistoricalMonthData(historicalMonth: monthDataProvider.monthHistoricalDataDay!, 
          childrens: temperatureMonthSection),
          const SizedBox(height: 10),
      ]
    );
  }
}


class _CardHistoricalMonthData extends StatelessWidget {

  final HistoricalMonth historicalMonth;
  final List<Widget> Function(ThemeData, HistoricalMonth) childrens;
  
  const _CardHistoricalMonthData({
    required this.historicalMonth,
    required this.childrens
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           ...childrens(theme, historicalMonth)
          ],
        ),
      )
    );
  }
}

