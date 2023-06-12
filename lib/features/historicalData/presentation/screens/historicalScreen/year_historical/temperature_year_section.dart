import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_agroup_year.dart';

import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_month.dart';
import 'package:el_tiempo_en_galve_app/features/shared/widgets/line_chart_slide_horizontal_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Widget> temperatureYearSection(ThemeData theme, HistoricalAgroupYear historicalYear) {
  List<HistoricalDataMonth> historicalDataMonthList = historicalYear.historicalDataMonth;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String formattedValueString = value.toStringAsFixed(1);
    double? formattedValue = double.tryParse(formattedValueString); // Formatea el valor a 1 decimal
    if (formattedValue != null && formattedValue % 1 == 0) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(formattedValueString.substring(
          0, formattedValueString.length -2
        )),
      );
    } else {
      return Container(); // No muestra ningún widget si el valor no es un entero
    }
  }


  return [
    Text("Temperatura", style: theme.textTheme.titleLarge),
    const SizedBox(height: 10,),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Máxima del año: ${historicalYear.maxTemp.value}ºC  -Mes: ${historicalYear.maxTemp.day}"),
        Text("Mínima del año: ${historicalYear.minTemp.value}ºC  -Mes: ${historicalYear.minTemp.day}"),
        const SizedBox(height: 20,),
      ],
    ),
    LineChartSlideHorizontalWidget(
      chartData: historicalDataMonthList.map((e) => ChartData(e.month.toDouble(), e.maxTemperature.toDouble())).toList(),
      chartData2: historicalDataMonthList.map((e) => ChartData(e.month.toDouble(), e.minTemperature.toDouble())).toList(),
      chartDataColor: Colors.red,
      chartData2Color: Colors.blue,
      bottomTitleWidget: bottomTitleWidgets,
      maxX: historicalDataMonthList[historicalDataMonthList.length -1].month.toDouble() + 2,
      maxXShow: historicalDataMonthList.length > 10 
        ? historicalDataMonthList[10].month.toDouble() 
        : historicalDataMonthList[historicalDataMonthList.length -1].month.toDouble(),
      minX: historicalDataMonthList[0].month.toDouble(),
      )
  ];
}