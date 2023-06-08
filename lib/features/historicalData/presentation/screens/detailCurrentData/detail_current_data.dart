import 'package:flutter/material.dart';

import '../../../../shared/widgets/widgets.dart';

class DetailCurrentData extends StatelessWidget {
  
  static const name = 'detail_current_data_screen';
  
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