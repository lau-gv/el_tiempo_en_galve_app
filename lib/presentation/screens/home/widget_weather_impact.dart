import 'package:flutter/material.dart';

import '../../../config/themes/dark_theme.dart';

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



class CardTimeChildrens extends StatelessWidget {
  const CardTimeChildrens({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);

    return Row(              
      children: [
        Expanded(
          flex: 16,
          child: Container(
            padding: const EdgeInsets.only(left: 12, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("17º", style: theme.textTheme.displayLarge, textScaleFactor: 1),
                Text("Hoy: 06/05/2023 23:40", style: theme.textTheme.bodyMedium),
                Text("Sensacion térmica: 25º C", style: theme.textTheme.bodyMedium),
                Text("Max 32º Min: 12º", style: theme.textTheme.bodyMedium),
                Text("Total lluvia: 2L", style: theme.textTheme.bodyMedium)
              ],
            ),
          ),
        ),
        
        Expanded(
          flex: 14,
          child: Transform.translate(
            offset: const Offset(9, -10),
            child: const Image(
              image: AssetImage("assets/images/sunwind.png"),
              fit: BoxFit.cover,
                          ),
          ))
      ],
    );
  }
}