import 'package:el_tiempo_en_galve_app/config/themes/dark_theme.dart';
import 'package:flutter/material.dart';

class LineFigure extends StatelessWidget {
  final Size size;
  const LineFigure({super.key, required this.size});

  @override
  Widget build(BuildContext context) {



    return SizedBox(
      width: size.width,
      height: 2,
      child: CustomPaint(
        painter: LineFigurePainter(),
      ),
    );
  }
}



//https://www.youtube.com/watch?v=GpxkQegspCk

//http://blog.geveo.com/Flutter-Custom-Paint-and-Clip-Path-for-highly-customized-UI-design
class LineFigurePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {


    final paint = Paint()
      ..color = DarkTheme.grey1
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width /2 + 40, 0);
    path.moveTo(0, 0);
    path.lineTo(size.width /2 - 40, 0);
      // Invertir coordenadas Y*/
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LineFigurePainter oldDelegate) => false;
}