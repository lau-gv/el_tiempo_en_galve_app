import 'package:auto_size_text/auto_size_text.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/domain/entities/current_station_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/themes/dark_theme.dart';
import '../../../historicalData/presentation/providers/currentStationData/current_station_data_provider.dart';
import '../../../historicalData/presentation/providers/historicalDataDay/today_data_provider.dart';

class WidgetWeatherImpact extends StatelessWidget {
  const WidgetWeatherImpact({super.key, 
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {

    final rectangleSize = height;
    return Stack(
      children: [
        Container(     
          height: rectangleSize,
          constraints: const BoxConstraints(
            minHeight: 170,
            maxHeight: 200
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: CustomPaint(
            painter: TrapezoidPainter(),
            child: const CardTimeChildrens()),
        ),
      ],
    );
  }
}

//https://www.youtube.com/watch?v=GpxkQegspCk

//http://blog.geveo.com/Flutter-Custom-Paint-and-Clip-Path-for-highly-customized-UI-design
class TrapezoidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final gradient = LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                DarkTheme.cardTimeTop,
                DarkTheme.cardTimeMiddle,
                DarkTheme.cardTimeDown
              ],
              stops: const [0.0, 0.35, 1]
            );

    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    const roundnessFactor = 30.0;
    final path = Path();
    path.moveTo(0, roundnessFactor);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - roundnessFactor);
    path.lineTo(size.width, size.height * (1 - 0.35));
    path.quadraticBezierTo(size.width, size.height * (1 - 0.45) - (roundnessFactor) / 1.2, size.width - roundnessFactor, size.height * (1 - 0.45) - roundnessFactor);
    path.lineTo(0 + roundnessFactor, 0);
    path.quadraticBezierTo(
        0, 0, 0, roundnessFactor);
      // Invertir coordenadas Y*/
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrapezoidPainter oldDelegate) => false;
}



class CardTimeChildrens extends ConsumerWidget {
  const CardTimeChildrens({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef  ref) {

    final stationCurrentData = ref.watch(currentStationDataProvider);
    final getHistoricalDataDay = ref.watch(todayHistoricalDataDayProvider);
    final theme = Theme.of(context);

    final actualTemp = stationCurrentData.currentStationData != null 
                      ? stationCurrentData.currentStationData!.temperature.toString() : "";
    final date = stationCurrentData.currentDate;
    final maxTemp = getHistoricalDataDay.historicalDataDay != null
                    ? getHistoricalDataDay.historicalDataDay!.maxTemperature
                    : "";
    final minTemp = getHistoricalDataDay.historicalDataDay != null
                    ? getHistoricalDataDay.historicalDataDay!.minTemperature
                    : "";
    final totalRain = getHistoricalDataDay.historicalDataDay != null
                    ? getHistoricalDataDay.historicalDataDay!.acumulateDailyraininmm : "";

    return Row(              
      children: [
        Expanded(
          flex: 13,
          child: Container(
            padding: const EdgeInsets.only(left: 12, top: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                AutoSizeText(
                  "$actualTempºC",
                  style: theme.textTheme.displayLarge, textScaleFactor: 1,
                  maxLines: 1,),
                const SizedBox(height: 2,),
                AutoSizeText("Hoy: $date",
                  style: theme.textTheme.bodyMedium, maxLines: 1,),
                AutoSizeText("Max $maxTempºC Min: $minTempºC", style: theme.textTheme.bodyMedium, maxLines: 1,),
                AutoSizeText("Total lluvia: ${totalRain}L", style: theme.textTheme.bodyMedium, maxLines: 1,)
              ],
            ),
          ),
        ),
        
        Expanded(
          flex: 12,
          child: Transform.translate(
            offset: const Offset(9, -25),
            child: const Image(
              image: AssetImage("assets/images/sunwind.png"),
              fit: BoxFit.contain,
            ),
          ))
      ],
    );
  }
}