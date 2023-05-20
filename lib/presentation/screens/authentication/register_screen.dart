import 'package:el_tiempo_en_galve_app/presentation/widgets/background_gradient.dart';
import 'package:el_tiempo_en_galve_app/presentation/widgets/input_password.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const name = 'register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BackgroundGradient(
      widget: Scaffold(
        appBar: AppBar(
          title: const Text("El tiempo en Galve"),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 150,
                    child: Image.asset(
                      'assets/images/logo/white_logo_app.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Registro",
                    style: theme.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 45),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Nombre"),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  const SizedBox(height: 15),
                  const InputPassword(textLabel: "contraseña"),
                  const SizedBox(height: 15),
                  const InputPassword(textLabel: "Confirmar contraseña"),
                  
                  const SizedBox(height: 20),
                 
                  FilledButton(
                    onPressed: () {},
                    child: Text(
                      'Registrar',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
