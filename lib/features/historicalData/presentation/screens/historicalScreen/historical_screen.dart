import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_agroup_month.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/monthWidget/month_widget_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/screens/historicalScreen/month_historical/month_historical_data_widget.dart';
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
      : HistoricalDataWidget(),
    );
  }
}

class HistoricalDataWidget extends StatelessWidget {
  const HistoricalDataWidget({
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
        body: const TabBarView(
          children: [              
            SingleChildScrollView(child: MonthHistoricalDataWidget(),),
            SingleChildScrollView(child: MonthHistoricalDataWidget(),),
            //SingleChildScrollView(child: YearHistoricalDataWidget(monthDataProvider: monthDataProvider),),
          ],
        ),
      ),
    );
  }
}



class _CardHistoricalMonthData extends StatelessWidget {

  final HistoricalAgroupMonth historicalMonth;
  final List<Widget> Function(ThemeData, HistoricalAgroupMonth) childrens;
  
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

