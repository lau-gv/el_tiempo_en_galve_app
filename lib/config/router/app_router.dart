import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/data/presentation/screens/detailCurrentData/detail_current_data.dart';
import '../../features/data/presentation/screens/historial_screen.dart';
import '../../features/home/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
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
  ]
);