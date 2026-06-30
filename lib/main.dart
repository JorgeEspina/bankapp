import 'package:bankapp/features/configuration/presentation/state/configuration_providers.dart';
import 'package:bankapp/core/l10n/locale_provider.dart';
import 'package:bankapp/core/l10n/app_localizations.dart';
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
    final config = ref.watch(configurationControllerProvider);
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      key: ValueKey(locale.languageCode),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(isDarkMode: config.isDarkMode).getTheme(),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
