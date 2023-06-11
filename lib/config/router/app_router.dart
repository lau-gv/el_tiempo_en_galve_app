import 'package:el_tiempo_en_galve_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:el_tiempo_en_galve_app/features/auth/presentation/screens/confirm_email_screen.dart';
import 'package:el_tiempo_en_galve_app/features/stations/presentation/screens/crete_station_screen.dart';
import 'package:el_tiempo_en_galve_app/features/stations/presentation/screens/edit_station_screen.dart';
import 'package:el_tiempo_en_galve_app/features/stations/presentation/screens/my_stations_screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:el_tiempo_en_galve_app/config/router/app_router_notifier.dart';
import 'package:el_tiempo_en_galve_app/features/splashScreen/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/historicalData/presentation/screens/detailCurrentData/detail_current_data.dart';
import '../../features/historicalData/presentation/screens/historicalScreen/historical_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    //Espera algo de tipo Listenable, el cual, cunado cambie, va a volver a evaluar el redirect    
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),      
      ),    
      GoRoute(
        path: '/',
        name: HomeScreen.name,
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
      GoRoute(
        path: '/login',
        name: LoginScreen.name,
        builder: (context, state) => const LoginScreen(),      
      ),
      GoRoute(
        path: '/register',
        name: RegisterScreen.name,
        builder: (context, state) => const RegisterScreen(),      
      ),  
      GoRoute(
        path: '/confirmScreen',
        name: ConfirmEmailScreen.name,
        builder: (context, state) => const ConfirmEmailScreen(),
      ),
      GoRoute(
        path: '/stations',
        name: MyStationsScreen.name,
        builder: (context, state) => const MyStationsScreen(),      
      ),   
      GoRoute(
        path: '/stationCreate',
        name: CreateStationScreen.name,
        builder: (context, state) => const CreateStationScreen(),      
      ),   
      GoRoute(
        path: '/stationEdit/:id',
        name: EditStationScreen.name,
        builder: (context, state) => EditStationScreen(
          stationId: state.pathParameters['id'] ?? 'no-id'
        ),      
      ),   
    ],

    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == 'splash' && authStatus == AuthStatus.checking) return null;

      if(authStatus == AuthStatus.notAuthenticated){
        //Rutas publicas, POR EJEMPLO
        if (isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/confirmScreen') return null;

        return '/login';
      }

      if(authStatus == AuthStatus.authenticated){
         if (isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash' ){
           return '/';
         }
      }
      return null;
    }
    //Aquí  podrdíamos poner más cosicas ^^.
  );
});