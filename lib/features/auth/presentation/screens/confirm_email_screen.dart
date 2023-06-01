import 'package:el_tiempo_en_galve_app/features/auth/presentation/providers/confirmation_code__form_provider.dart';
import 'package:el_tiempo_en_galve_app/features/auth/presentation/providers/register_provider.dart';
import 'package:el_tiempo_en_galve_app/features/auth/presentation/screens/showSnackbar.dart';
import 'package:el_tiempo_en_galve_app/features/shared/widgets/custom_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/background_gradient.dart';
import '../../../shared/widgets/line_figure.dart';

class ConfirmEmailScreen extends ConsumerWidget {
  static const name = 'confirm_email_screen';
 
  const ConfirmEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final confirmForm = ref.watch(confirmationCodeProvider);
    //Para mostrar el error, debemos escuchar los cambios!!!
    //A quien escuchamos, estado anterior, estado siguiente.
    //Cuando el refWidget se destruya también limpia el listener ^^ Esa es una cosa maja de Riverpod.
    ref.listen(registerProvider, (previous, next) {
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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                      const SizedBox(height: 30),
              
                      Text(
                        "Confirma tu email",
                        style: theme.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 30),
                      //ref.read(loginFormProvider.notifier).onEmailChange,
                      //loginForm.email.errorMessage,
                      CustomInputText(
                        textLabel: "Codigo de verificacion",
                        keyboardType: TextInputType.emailAddress,
                        errorMessage: confirmForm.confirmationCode.errorMessage,
                        onChanged: ref.read(confirmationCodeProvider.notifier).onConfirmationCodeChange,
                      ),
                      const SizedBox(height: 10),
              
                      FilledButton(
                        onPressed: () {
                          bool shouldNavigate = false;
                          ref.read(confirmationCodeProvider.notifier).onFormSubmit().then((_){
                            if(ref.read(confirmationCodeProvider).isUserConfirmed) shouldNavigate = true;
                          }).whenComplete((){
                            if(shouldNavigate) context.push("/");
                          });
                        },
                        child: const Text('Confirmar', style: TextStyle(fontSize: 25),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ])
                  ),
                  LineFigure(size: screenSize),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
