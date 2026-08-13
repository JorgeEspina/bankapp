import 'dart:async';

import 'package:bankapp/features/configuration/presentation/state/configuration_providers.dart';
import 'package:bankapp/core/l10n/locale_provider.dart';
import 'package:bankapp/core/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:bankapp/core/router/app_router.dart';
import 'package:bankapp/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'core/notifications/notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationService.instance.initialize();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  late final StreamSubscription<String> _notificationSubscription;
  late final StreamSubscription<String> _foregroundSubscription;
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _notificationSubscription = NotificationService.instance.onNotificationTap
        .listen((route) => ref.read(appRouterProvider).go(route));
    _foregroundSubscription = NotificationService.instance.onForegroundMessage
        .listen((message) {
      _messengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = NotificationService.instance.takePendingRoute();
      if (route != null) ref.read(appRouterProvider).go(route);
    });
  }

  @override
  void dispose() {
    _notificationSubscription.cancel();
    _foregroundSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(configurationControllerProvider);
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      scaffoldMessengerKey: _messengerKey,
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
