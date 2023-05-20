import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';

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