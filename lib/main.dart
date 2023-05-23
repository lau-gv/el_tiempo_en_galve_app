
import 'package:el_tiempo_en_galve_app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  
  await Enviroment.initEnviroment();

  runApp(const ProviderScope(child: MyApp()));
} 

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appRouter = ref.watch(goRouterProvider);
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: 'El Tiemo en Galve',
      theme: DarkTheme().getTheme(),
    );
  }
}