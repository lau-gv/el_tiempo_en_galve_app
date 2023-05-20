import 'package:el_tiempo_en_galve_app/presentation/widgets/background_gradient.dart';
import 'package:el_tiempo_en_galve_app/presentation/widgets/input_password.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class LoginScreen extends StatelessWidget {
  static const name = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

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
              child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/images/logo/white_logo_app.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      "Login",
                      style: theme.textTheme.displayMedium,
                    ),                    
                    const SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: "Email"),
                    ),
                    const SizedBox(height: 30),
                    const InputPassword(textLabel: "Contraseña"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "¿No tienes una cuenta?",
                          style: theme.textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            context.replace('/register');
                          },
                          child: const Text(
                            "Regístrate",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    FilledButton(
                      onPressed: () {},
                      child: const Text(
                        'Login',
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
