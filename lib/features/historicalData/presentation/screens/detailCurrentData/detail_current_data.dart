import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/providers/historicalDataDay/today_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/widgets.dart';

class DetailCurrentData extends ConsumerWidget {
  
  static const name = 'detail_current_data_screen';
  
  const DetailCurrentData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final todayHistoricalDataday = ref.watch(todayHistoricalDataDayProvider).historicalDataDay;

    return BackgroundGradient(
      widget: Scaffold(
        appBar: AppBar(
          title: const Text("Condiciones hoy"),
        ),
      ),
    );
  }
}