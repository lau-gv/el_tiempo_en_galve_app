import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/monthWidget/month_widget_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/yearWidget/year_widget_provider.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/screens/historicalScreen/month_historical/month_historical_data_widget.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/screens/historicalScreen/year_historical/year_historical_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/widgets.dart';

class HistoricalScreen extends ConsumerWidget {
  
  static const name = 'historical_screen';
  
  const HistoricalScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    
    final monthDataProvider = ref.watch(monthHistoricalDataProvider);
    final yearDataProvider = ref.watch(yearHistoricalDataProvider);

    return BackgroundGradient(
      widget: monthDataProvider.isLoading || yearDataProvider.isLoading
      ? const Center(child: CircularProgressIndicator())
      : const HistoricalDataWidget(),
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
            SingleChildScrollView(child: YearHistoricalDataWidget(),),
            //SingleChildScrollView(child: YearHistoricalDataWidget(monthDataProvider: monthDataProvider),),
          ],
        ),
      ),
    );
  }
}



