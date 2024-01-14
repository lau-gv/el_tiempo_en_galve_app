
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/station_data.dart';
import 'package:el_tiempo_en_galve_app/features/shared/widgets/hour_chart_slideline_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

//List<Widget> temperatureDaySection(ThemeData theme, List<StationData> stationDataList) {
//  
//  List<StationData> stationDataDayList = stationDataList;
//
//  return [
//    Text("Temperatura", style: theme.textTheme.titleLarge),
//    const SizedBox(height: 10,),
//    Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: [
//        const Text("Máxima del dia: 1"),
//        const Text("Mínima del dia: 2"),
//        const SizedBox(height: 20,),
//
//        //Aquí lo que hay es pasar el listado de datos que corresponde ^^
//        HourChartSlidelineWidget(spots: 
//          List.generate(24 * 12, (i) => i.toDouble() / 12) // Suponiendo 25 horas con intervalos de 5 minutos
//          .map((x) => FlSpot(x, cos(x * 0.1))) // Suponiendo la función cos(x*0.1)
//          .toList(),),
//      ],
//    ),
//    
//  ];
//}
List<Widget> temperatureDaySection(ThemeData theme, List<StationData> stationdata) {
  
  StationData? stationDataMaxTemp;
  StationData? stationDataMinTemp;
  //Primero, necesitamos calcular los puntos.
  if (stationdata.isNotEmpty) {
    stationDataMaxTemp = stationdata.reduce((maximo, stationdata) => stationdata.temperature > maximo.temperature ? stationdata : maximo);
     stationDataMinTemp = stationdata.reduce((maximo, stationdata) => stationdata.temperature < maximo.temperature ? stationdata : maximo);
  }

  return [
    const SizedBox(height: 10,),
    Text("Evolución de la temperatura", style: theme.textTheme.titleLarge),
    const SizedBox(height: 10,),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Máxima del dia: ${stationDataMaxTemp?.temperature ?? 0} ºC a las ${stationDataMaxTemp?.getHHMMString() ?? ""} h" ),
        Text("Mínima del dia: ${stationDataMinTemp?.temperature ?? 0} ºC a las ${stationDataMinTemp?.getHHMMString() ?? ""} h" ),
        const SizedBox(height: 20,),
      ],
    ),
    HourChartSlidelineWidget(
      spots: stationdata.map((e) => FlSpot(e.getHoras().toDouble(), e.temperature.toDouble())).toList(),
      maxY: stationDataMaxTemp?.temperature ?? 0,
      minY: stationDataMinTemp?.temperature ?? 0
    )
  ];
}
