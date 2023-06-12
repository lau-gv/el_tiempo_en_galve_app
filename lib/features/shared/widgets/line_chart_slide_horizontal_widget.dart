import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

//Aquí gracias. Esto es de esta persona, yo solo lo he modificado un poquito.
//https://github.com/imaNNeo/fl_chart/issues/71#issuecomment-1414267612

class LineChartSlideHorizontalWidget extends StatelessWidget {

  final List<ChartData> chartData;
  final List<ChartData>? chartData2;
  final Color chartDataColor;
  final Color? chartData2Color;
  final double maxX;
  final double minX;
  final double maxXShow;
  final Widget Function(double, TitleMeta)? bottomTitleWidget;


  
  const LineChartSlideHorizontalWidget({
    required this.chartData,
    this.chartData2,
    required this.chartDataColor,
    this.chartData2Color,
    required this.maxX,
    required this.minX,
    required this.maxXShow,
    this.bottomTitleWidget,
    Key? key,
    })
      : super(key: key);


  @override
  Widget build(BuildContext context) {


    return SizedBox(
      height: 350,
      child: AspectRatio(
        aspectRatio: 4,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ZoomableChart(
            maxX: maxX,
            minX:  minX,
            maxXShow: maxXShow,
            
            builder: (minX, maxX) {
              return LineChart(
                LineChartData(
                  clipData: const FlClipData.all(),
                  minX: minX,
                  maxX: maxX,
                  
                  lineTouchData: const LineTouchData(enabled:true),
                  lineBarsData: [
                    ...buildLineBarsData(chartData, chartData2, chartDataColor, chartData2Color)
                  ],
                  borderData: FlBorderData(
                    show: true,
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) => 
                        bottomTitleWidget != null ? bottomTitleWidget!(value, meta) : defaultGetTitle(value, meta),
                      )                    
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false, reservedSize: 30)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  )
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

List<LineChartBarData> buildLineBarsData(List<ChartData> chartData, List<ChartData>? chartData2, 
Color chartDataColor, Color? chartData2Color) {
    List<LineChartBarData> lineBarsData = [
      LineChartBarData(
        spots: chartData.map((point) => FlSpot(point.x, point.y)).toList(),
        isCurved: false,
        barWidth: 2,
        color: chartDataColor,
        dotData: const FlDotData(
          show: true,
        ),
      ),
  ];

  if (chartData2 != null) {
    lineBarsData.add(LineChartBarData(
        spots: chartData2.map((point) => FlSpot(point.x, point.y)).toList(),
        isCurved: false,
        barWidth: 2,
        color: chartData2Color ?? chartDataColor,
        dotData: const FlDotData(
          show: true,
      ),
    ));
  }

  return lineBarsData;
}

Widget defaultGetTitle(double value, TitleMeta meta) {
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      meta.formattedValue,
    ),
  );
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}
class ZoomableChart extends StatefulWidget {
  const ZoomableChart({
    Key? key,
    required this.maxX,
    required this.minX,
    required this.maxXShow,
    required this.builder,
  }) : super(key: key);

  final double maxX;
  final double minX;
  final double maxXShow;
  final Widget Function(double, double) builder;

  @override
  State<ZoomableChart> createState() => _ZoomableChartState();
}

class _ZoomableChartState extends State<ZoomableChart> {
  late double minX;
  late double maxX;
  late double initialMaxX;

  late double lastMaxXValue;
  late double lastMinXValue;

  @override
  void initState() {
    super.initState();
    minX = widget.minX;
    initialMaxX = widget.maxX + 0.1;
    maxX = widget.maxXShow + 0.1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          minX = widget.minX;
          maxX = initialMaxX;
        });
      },
      onHorizontalDragStart: (details) {
        lastMinXValue = minX;
        lastMaxXValue = maxX;
      },
      onHorizontalDragUpdate: (details) {
        var horizontalDistance = details.primaryDelta ?? 0;
        if (horizontalDistance == 0) return;
        var lastMinMaxDistance = max(lastMaxXValue - lastMinXValue, 0.0);

        setState(() {
          minX -= lastMinMaxDistance * 0.005 * horizontalDistance;
          maxX -= lastMinMaxDistance * 0.005 * horizontalDistance;

          if (minX < 0) {
            minX = 0;
            maxX = lastMinMaxDistance;
          }
          if (maxX > initialMaxX) {
            maxX = initialMaxX;
            minX = maxX - lastMinMaxDistance;
          }
        });
      },
      child: widget.builder(minX, maxX),
    );
  }
}
