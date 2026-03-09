import 'package:bankapp/features/configuration/presentation/state/configuration_provider.dart';
import 'package:flutter/material.dart';
import 'package:bankapp/core/router/app_router.dart';
import 'package:bankapp/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final config = ref.watch(configurationProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(isDarkMode: config.isDarkMode).getTheme(),
    );
  }
}