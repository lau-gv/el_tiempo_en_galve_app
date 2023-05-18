import 'package:flutter/material.dart';

import '../../widgets/gradient_scaffold.dart';

class HistoricalScreen extends StatelessWidget {
  
  static const name = 'historical_screen';
  
  const HistoricalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      widget: Scaffold(
        appBar: AppBar(
          title: const Text("Historico de datos"),
        ),
      ),
    );
  }
}