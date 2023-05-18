import 'package:flutter/material.dart';

import '../../widgets/gradient_scaffold.dart';

class RegisterScreen extends StatelessWidget {
  
  static const name = 'register_screen';
  
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackgroundGradient(
      widget: Scaffold(
        body: Text("Registro"),
      ),
    );
  }
}