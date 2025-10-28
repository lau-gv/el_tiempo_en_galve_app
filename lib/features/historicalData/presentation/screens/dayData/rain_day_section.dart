
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/station_data.dart';
import 'package:el_tiempo_en_galve_app/features/shared/widgets/hour_chart_slideline_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Widget> rainDaySection(ThemeData theme, List<StationData> stationdata) {
  
  StationData? stationDailyRainin;

  //Primero, necesitamos calcular los puntos.
  if (stationdata.isNotEmpty) {

    stationDailyRainin = stationdata.reduce((maximo, stationdata) => stationdata.dailyraininmm > maximo.dailyraininmm ? stationdata : maximo);
  }

  return [
    const SizedBox(height: 10,),
    Text("Evolución de la lluvia", style: theme.textTheme.titleLarge),
    const SizedBox(height: 10,),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Total max lluvia: ${stationDailyRainin?.dailyraininmm ?? 0} mm a las ${stationDailyRainin?.getHHMMString() ?? ""} h" ),
        const SizedBox(height: 20,),
      ],
    ),
    HourChartSlidelineWidget(
      spots: stationdata.map((e) => FlSpot(e.getHoras().toDouble(), e.dailyraininmm)).toList(),
      maxY: stationDailyRainin?.dailyraininmm ?? 0,
      minY:  0
    )
  ];
}
