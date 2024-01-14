import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

class HourChartSlidelineWidget extends StatelessWidget {

  final List<FlSpot> spots;
  final double minY;
  final double maxY;
  const HourChartSlidelineWidget({super.key, required this.spots, required this.minY, required this.maxY});

Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
  final hoursToShow = [0, 4, 8, 12, 16, 20, 23];

  // Verificar que el valor sea una hora exacta
  if (!hoursToShow.contains(value.toInt()) || value % 1 != 0) {
    return Container();
  }

  final hours = (value.toInt());
  final minutes = ((value - hours) * 60).round();
  final formattedTime = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 10,
    child: Transform.rotate(
      angle: -0.85,
      child: Text(formattedTime),
    ),
  );
}

  Widget leftTitleWidgets(double value, TitleMeta meta, double chartWidth) {

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(meta.formattedValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 1,
          bottom: 10,
          right: 20,
          top: 20,
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      maxContentWidth: 100,
                      tooltipBgColor: Colors.black,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((LineBarSpot touchedSpot) {
                          final textStyle = TextStyle(
                            color: touchedSpot.bar.gradient?.colors[3] ??
                                touchedSpot.bar.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          );
                          final yValue = touchedSpot.y.toStringAsFixed(2);
                          final xValue = valueToHHMM(touchedSpot.x);
                          return LineTooltipItem(
                            '$xValue, $yValue',
                            textStyle,
                          );
                        }).toList();
                      },
                    ),
                    handleBuiltInTouches: true,
                    getTouchLineStart: (data, index) => 0,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      color: Colors.red.shade600,
                      spots: spots,
                      isCurved: true,
                      isStrokeCapRound: true,
                      barWidth: 2,
                      belowBarData: BarAreaData(
                        show: false,
                      ),
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                  minY: minY > 0 ? -1 : minY,
                  maxY: maxY,
                  maxX: 23.99,
                  minX: 0,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) =>
                            leftTitleWidgets(value, meta, constraints.maxWidth),
                        reservedSize: 60,
                      ),
                      drawBelowEverything: true,
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) =>
                            bottomTitleWidgets(value, meta, constraints.maxWidth),
                        reservedSize: 50,
                        interval: 1,
                      ),
                      drawBelowEverything: true,
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: true,
                    horizontalInterval: 1,
                    verticalInterval: 4,
                    checkToShowHorizontalLine: (value) {
                      return value.toInt() == 0;
                    },
                    getDrawingHorizontalLine: (_) => const FlLine(
                      color: Colors.blue,
                      dashArray: [8, 2],
                      strokeWidth: 0.8,
                    ),
                    getDrawingVerticalLine: (_) => const FlLine(
                      color: Colors.white30,
                      dashArray: [8, 2],
                      strokeWidth: 0.8,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String valueToHHMM(double value){
    final hours = (value.toInt());
    final minutes = ((value - hours) * 60).round();
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}