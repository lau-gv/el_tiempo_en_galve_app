import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/screens/detailCurrentData/detail_current_data.dart';
import 'package:el_tiempo_en_galve_app/features/historicalData/presentation/screens/historicalScreen/historical_screen.dart';
import 'package:el_tiempo_en_galve_app/features/home/presentation/screens/home_screen.dart';
import 'package:el_tiempo_en_galve_app/features/splashScreen/splash_screen.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final appRouterNoLogin = GoRouter(

  initialLocation: '/',
  
  routes: [
    GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),      
      ),  

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
      GoRoute(
        path: '/detail-current-data',
        name: DetailCurrentData.name,
        builder: (context, state) => const DetailCurrentData(),      
      ),
      GoRoute(
        path: '/historical-data',
        name: HistoricalScreen.name,
        builder: (context, state) => const HistoricalScreen(),      
      ),    
  ],
);