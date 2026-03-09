import 'package:bankapp/features/configuration/presentation/screens/configuration_screen.dart';
import 'package:bankapp/features/home/presentation/screens/cards/cards_screen.dart';
import 'package:bankapp/features/home/presentation/screens/reports/historial_screen.dart';
import 'package:bankapp/features/home/presentation/screens/transfers/transferencias_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:bankapp/features/authentication/presentation/screens/screens.dart';
import 'package:bankapp/features/home/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: SignInScreen.name,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/transfers',
      name: TransferenciasScreen.name,
      builder: (context, state) => const TransferenciasScreen(),
    ),
    GoRoute(
      path: '/reports',
      name: HistorialScreen.name,
      builder: (context, state) => const HistorialScreen(),
    ),
    GoRoute(
      path: '/configuration',
      name: ConfigurationScreen.name,
      builder: (context, state) => const ConfigurationScreen(),
    ),
    GoRoute(
      path: '/cards',
      name: CardsScreen.name,
      builder: (context, state) => const CardsScreen(),
    ),
  ],
);