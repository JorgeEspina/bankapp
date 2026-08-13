import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const _channel = AndroidNotificationChannel(
    'bankapp_high_importance',
    'Notificaciones importantes',
    description: 'Transferencias, campañas y alertas de BankApp.',
    importance: Importance.high,
  );

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final StreamController<String> _tapController =
      StreamController<String>.broadcast();
  final StreamController<String> _foregroundController =
      StreamController<String>.broadcast();
  String? _pendingRoute;
  bool _enabled = false;

  Stream<String> get onNotificationTap => _tapController.stream;
  Stream<String> get onForegroundMessage => _foregroundController.stream;

  String? takePendingRoute() {
    final route = _pendingRoute;
    _pendingRoute = null;
    return route;
  }

  Future<void> initialize() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _localNotifications.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        _openRoute(response.payload);
      },
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    FirebaseMessaging.onMessage.listen(_showForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_openRemoteMessage);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      Future<void>.delayed(
        Duration.zero,
        () => _openRemoteMessage(initialMessage),
      );
    }
  }

  Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    _enabled = settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
    return _enabled;
  }

  Future<void> disable() async {
    _enabled = false;
    await _messaging.deleteToken();
  }

  Future<String?> getToken() async {
    const vapidKey = String.fromEnvironment(
      'FIREBASE_WEB_VAPID_KEY',
    );

    final token = await _messaging.getToken(
      vapidKey: kIsWeb && vapidKey.isNotEmpty ? vapidKey : null,
    );

    if (kDebugMode) {
      debugPrint('========================================');
      debugPrint('TOKEN FCM: $token');
      debugPrint('========================================');
    }

    return token;
  }

  Future<void> showTransferConfirmation({
    required String description,
    required double amount,
  }) async {
    if (!_enabled) return;
    await _localNotifications.show(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title: 'Transferencia registrada',
      body: '$description · Q${amount.toStringAsFixed(2)}',
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'bankapp_high_importance',
          'Notificaciones importantes',
          channelDescription: 'Transferencias, campañas y alertas de BankApp.',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: '/reports',
    );
  }

  Future<void> _showForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;

    debugPrint('========================================');
    debugPrint('NOTIFICACIÓN FCM RECIBIDA');
    debugPrint('Message ID: ${message.messageId}');
    debugPrint('Título: ${notification?.title}');
    debugPrint('Mensaje: ${notification?.body}');
    debugPrint('Datos adicionales: ${message.data}');
    debugPrint('Fecha: ${message.sentTime}');
    debugPrint('========================================');

    if (notification == null) {
      debugPrint(
        'La notificación no tiene título ni mensaje; '
        'solamente contiene datos.',
      );
      return;
    }

    await _localNotifications.show(
      id: notification.hashCode,
      title: notification.title ?? 'BankApp',
      body: notification.body ?? '',
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'bankapp_high_importance',
          'Notificaciones importantes',
          channelDescription:
              'Transferencias, campañas y alertas de BankApp.',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: _routeFromData(message.data),
    );

    final text = [
      notification.title,
      notification.body,
    ]
        .whereType<String>()
        .where((value) => value.isNotEmpty)
        .join(': ');

    _foregroundController.add(
      text.isEmpty ? 'Nueva notificación' : text,
    );
  }

  // void _openRemoteMessage(RemoteMessage message) {
  //   _openRoute(_routeFromData(message.data));
  // }

  void _openRemoteMessage(RemoteMessage message) {
    final route = _routeFromData(message.data);

    debugPrint('========================================');
    debugPrint('NOTIFICACIÓN FCM PRESIONADA');
    debugPrint('Message ID: ${message.messageId}');
    debugPrint('Título: ${message.notification?.title}');
    debugPrint('Mensaje: ${message.notification?.body}');
    debugPrint('Datos: ${message.data}');
    debugPrint('Ruta: $route');
    debugPrint('========================================');

    _openRoute(route);
  }

  String _routeFromData(Map<String, dynamic> data) {
    final route = data['route']?.toString();
    return route != null && route.startsWith('/') ? route : '/home';
  }

  void _openRoute(String? route) {
    final safeRoute =
        route != null && route.startsWith('/') ? route : '/home';
    if (_tapController.hasListener) {
      _tapController.add(safeRoute);
    } else {
      _pendingRoute = safeRoute;
    }
  }
}
