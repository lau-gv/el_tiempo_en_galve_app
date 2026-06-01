import 'package:el_tiempo_en_galve_app/config/config.dart';
import 'package:el_tiempo_en_galve_app/config/services/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Google Mobile Ads
  await MobileAds.instance.initialize();

  await Enviroment.initEnviroment();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final AdService _adService = AdService();
  AppLifecycleState? _lastLifecycleState;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialAd();
    });
  }

  void _loadInitialAd() {
    _adService.showAppOpenAd();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        _lastLifecycleState != AppLifecycleState.resumed) {
      debugPrint('App returned to foreground - showing ad');
      _adService.showAppOpenAd();
    }

    _lastLifecycleState = state;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _adService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouterNoLogin,
        title: 'El Tiempo en Galve',
        theme: DarkTheme().getTheme(),
      ),
    );
  }
}