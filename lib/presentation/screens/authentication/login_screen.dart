import 'package:flutter/material.dart';

import '../../widgets/gradient_scaffold.dart';

class LoginScreen extends StatelessWidget {
  
  static const name = 'login_screen';
  
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackgroundGradient(
      widget: Scaffold(
        body: Text("Login"),
      ),
    );
  }
}