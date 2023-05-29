import 'package:el_tiempo_en_galve_app/features/auth/presentation/screens/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/widgets.dart';
import '../providers/authProviders.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerWidget {
  static const name = 'register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final registerForm = ref.watch(registerFormProvider);

    ref.listen(authProvider, (previous, next) {
      if(next.errorMessage.isEmpty) return;
      showSnackbar(context, next.errorMessage);
    });

    final theme = Theme.of(context);
    final Size screenSize = MediaQuery.of(context).size;

    return BackgroundGradient(
      widget: Scaffold(
        appBar: AppBar(
          title: const Text("El tiempo en Galve"),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    CustomInputText(
                      textLabel: "Usuario",
                      errorMessage: registerForm.username.errorMessage,
                      onChanged: ref.read(registerFormProvider.notifier).onUsernameChange,
                    ),
                    CustomInputText(
                      textLabel: "Email", 
                      keyboardType: TextInputType.emailAddress,
                      errorMessage: registerForm.email.errorMessage,  
                      onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
                    ),
                    const SizedBox(height: 5),
                    InputPassword(
                      textLabel: "Contraseña",
                      errorMessage: registerForm.password.errorMessage,
                      onChanged: ref.read(registerFormProvider.notifier).onPasswordChanged,
                    ),
                    InputPassword(
                      textLabel: "confirmar contraseña",
                      errorMessage: registerForm.repeatedPassword.errorMessage,
                      onChanged: ref.read(registerFormProvider.notifier).onRepeatedPasswordChanged,
                    ),
              
                   
                    FilledButton(
                      onPressed: () {
                        
                        ref.read(registerFormProvider.notifier).onFormSubmit();
                        ref.read(registerFormProvider).isValidUser ? context.push("/confirmScreen") : null;
                      },
                      child: const Text(
                        'Registrar',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    const SizedBox(height: 20),
                    LineFigure(size: screenSize)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
