import 'package:flutter/material.dart';
import 'package:fluter_test_luis1/features/login/presentation/views/login_view.dart';
import 'package:fluter_test_luis1/features/recharge/presentation/pages/recharge_page.dart';

class AppRoutes {
  static const login = '/';
  static const recharge = '/recharge';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginView(),
    recharge: (context) => const RechargePage(),
  };
}