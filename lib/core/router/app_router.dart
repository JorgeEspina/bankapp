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
  ],
);