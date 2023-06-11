import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_data_day.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/historical_agroup_month.dart';
import 'package:el_tiempo_en_galve_app/features/shared/widgets/line_chart_slide_horizontal_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Widget> temperatureMonthSection(ThemeData theme, HistoricalAgroupMonth historicalMonth) {
  List<HistoricalDataDay> historicalDataDayList = historicalMonth.historicalDataDays;

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
        Text("Máxima del mes: ${historicalMonth.maxTemp.value}ºC  -Dia: ${historicalMonth.maxTemp.day}"),
        Text("Mínima del mes: ${historicalMonth.minTemp.value}ºC  -Dia: ${historicalMonth.minTemp.day}"),
        const SizedBox(height: 20,),
      ],
    ),
    LineChartSlideHorizontalWidget(
      chartData: historicalDataDayList.map((e) => ChartData(e.day.toDouble(), e.maxTemperature.toDouble())).toList(),
      chartData2: historicalDataDayList.map((e) => ChartData(e.day.toDouble(), e.minTemperature.toDouble())).toList(),
      chartDataColor: Colors.red,
      chartData2Color: Colors.blue,
      bottomTitleWidget: bottomTitleWidgets,
      maxX: historicalDataDayList[historicalDataDayList.length -1].day.toDouble() + 2,
      maxXShow: historicalDataDayList.length > 10 
        ? historicalDataDayList[10].day.toDouble() 
        : historicalDataDayList[historicalDataDayList.length -1].day.toDouble(),
      minX: historicalDataDayList[0].day.toDouble(),
      )
  ];
}
