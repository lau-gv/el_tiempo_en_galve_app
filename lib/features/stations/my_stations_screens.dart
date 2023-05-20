import 'package:flutter/material.dart';

import '../shared/widgets/background_gradient.dart';

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