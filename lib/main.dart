import 'package:el_tiempo_en_galve_app/config/router/app_router.dart';
import 'package:el_tiempo_en_galve_app/config/themes/dark_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: 'El Tiemo en Galve',
      theme: DarkTheme().getTheme(),
    );
  }
}