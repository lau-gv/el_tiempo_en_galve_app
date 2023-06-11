import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

//En pendientes:
//https://github.com/imaNNeo/fl_chart/issues/71#issuecomment-1414267612

class LineChartWidget extends StatelessWidget {
  
  const LineChartWidget({Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
        final List<ChartData> chartData = [
    ChartData(2000, 10),
    ChartData(2001, 10),
    ChartData(2002, 10),
    ChartData(2003, 12),
    ChartData(2004, 13),
    ChartData(2005, 20),
    ChartData(2006, 25),
    ChartData(2007, 36),
    ChartData(2008, 37),
    ChartData(2009, 40),
    ChartData(2010, 50),
    ChartData(2011, 60),
    ChartData(2012, 10),
    ChartData(2013, 20),
    ChartData(2014, 15),
    ChartData(2015, 15),
    ChartData(2016, 15),
    ChartData(2017, 15),
    ChartData(2018, 15),
    ChartData(2019, 15),
    ChartData(2020, 15),
    ChartData(2021, 15),
    ChartData(2022, 15),
    ChartData(2023, 15),
    ChartData(2024, 15),
    ChartData(2025, 15),
    ChartData(2026, 15),
    ChartData(2027, 15),
    ChartData(2028, 15),
    ChartData(2029, 15),
    ChartData(2030, 15),
];
        final List<ChartData> chartData2 = [
    ChartData(2000, 8),
    ChartData(2001, 3),
    ChartData(2002, 5),
    ChartData(2003, 6),
    ChartData(2004, 4),
    ChartData(2005, 9),
    ChartData(2006, 10),
    ChartData(2007, 15),
    ChartData(2008, 18),
    ChartData(2009, 20),
    ChartData(2010, 30),
    ChartData(2011, 40),
    ChartData(2012, 6),
    ChartData(2013, 3),
    ChartData(2014, 2),
    ChartData(2015, 7),
    ChartData(2016, 6),
    ChartData(2017, 9),
    ChartData(2018, 15),
    ChartData(2019, 15),
    ChartData(2020, 15),
    ChartData(2021, 15),
    ChartData(2022, 15),
    ChartData(2023, 15),
    ChartData(2024, 15),
    ChartData(2025, 15),
    ChartData(2026, 15),
    ChartData(2027, 15),
    ChartData(2028, 15),
    ChartData(2029, 15),
    ChartData(2030, 15),
];


  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 18 * chartWidth / 500,
    );
    String text = value.toString();
      return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }


    return Container(
      height: 350, // Ajusta la altura según tus necesidades
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          AspectRatio(
            aspectRatio: 4,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: chartData.map((point) => FlSpot(point.x, point.y)).toList(),
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 2
                  ),
                  LineChartBarData(
                    spots: chartData2.map((point) => FlSpot(point.x, point.y)).toList(),
                    isCurved: true,
                    color: Colors.blue
                  ),
                ],  
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                   axisNameSize: 16,
                   sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,                    
                   )
                  )
                )  
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}