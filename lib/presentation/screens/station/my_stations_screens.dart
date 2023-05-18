import 'package:flutter/material.dart';

import '../../widgets/gradient_scaffold.dart';

class MyStationsScreen extends StatelessWidget {
  
  static const name = 'login_screen';
  
  const MyStationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackgroundGradient(
      widget: Scaffold(
        body: Text("My Stations"),
      ),
    );
  }
}