import 'package:el_tiempo_en_galve_app/features/shared/widgets/line_chart_zommable_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

//En pendientes:
//https://github.com/imaNNeo/fl_chart/issues/71#issuecomment-1414267612

class LineChar2tWidget extends StatelessWidget {
  
  const LineChar2tWidget({Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
        final List<ChartData> chartData = [
    ChartData(200, 10),
    ChartData(201, 10),
    ChartData(202, 10),
    ChartData(203, 12),
    ChartData(204, 13),
    ChartData(205, 20),
    ChartData(206, 25),
    ChartData(207, 36),
    ChartData(208, 37),
    ChartData(209, 40),
    ChartData(210, 50),
    ChartData(211, 60),
    ChartData(212, 10),
    ChartData(213, 20),
    ChartData(214, 15),
    ChartData(215, 15),
    ChartData(216, 15),
    ChartData(217, 15),
    ChartData(218, 15),
    ChartData(219, 15),
    ChartData(220, 15),
    ChartData(221, 15),
    ChartData(222, 15),
    ChartData(223, 15),
    ChartData(224, 15),
    ChartData(225, 15),
    ChartData(226, 15),
    ChartData(227, 15),
    ChartData(228, 15),
    ChartData(229, 15),
    ChartData(230, 15),
];
        final List<ChartData> chartData2 = [
    ChartData(200, 8),
    ChartData(201, 3),
    ChartData(202, 5),
    ChartData(203, 6),
    ChartData(204, 4),
    ChartData(205, 9),
    ChartData(206, 10),
    ChartData(207, 15),
    ChartData(208, 18),
    ChartData(209, 20),
    ChartData(210, 30),
    ChartData(211, 40),
    ChartData(212, 6),
    ChartData(213, 3),
    ChartData(214, 2),
    ChartData(215, 7),
    ChartData(216, 6),
    ChartData(217, 9),
    ChartData(218, 15),
    ChartData(219, 15),
    ChartData(220, 15),
    ChartData(221, 15),
    ChartData(222, 15),
    ChartData(223, 15),
    ChartData(224, 15),
    ChartData(225, 15),
    ChartData(226, 15),
    ChartData(227, 15),
    ChartData(228, 15),
    ChartData(229, 15),
    ChartData(230, 15),
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
      height: 350,
      child: AspectRatio(
        aspectRatio: 4,
        child: ZoomableChart(
          maxX: chartData[chartData.length - 1].x,
          minX:  chartData[0].x,
          maxXShow: chartData[chartData.length~/2 -5].x,
          builder: (minX, maxX) {
            return LineChart(
              LineChartData(
                clipData: FlClipData.all(),
                minX: minX,
                maxX: maxX,
                lineTouchData: LineTouchData(enabled: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: chartData2.map((point) => FlSpot(point.x, point.y)).toList(),
                    isCurved: false,
                    barWidth: 2,
                    color: Colors.red,
                    dotData: FlDotData(
                      show: true,
                    ),
                  ),
                ],
                minY: 1,
                borderData: FlBorderData(
                  show: true,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}