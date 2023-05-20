import 'package:flutter/material.dart';

import '../../widgets/background_gradient.dart';

class DetailCurrentData extends StatelessWidget {
  
  static const name = 'detail_current_data';
  
  const DetailCurrentData({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      widget: Scaffold(
        appBar: AppBar(
          title: const Text("Condiciones hoy"),
        ),
      ),
    );
  }
}