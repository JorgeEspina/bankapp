import 'package:flutter/material.dart';

class HomeMenuItem {
  final String title;
  final IconData icon;
  final String? link;

  const HomeMenuItem({
    required this.title,
    required this.icon,
    this.link,
  });
}


const List<HomeMenuItem> accountActions = [
  HomeMenuItem(title: 'Transferir', link: '/transfers', icon: Icons.swap_horiz),
  HomeMenuItem(title: 'Pagos', link: '/payments', icon: Icons.payment_outlined),
  HomeMenuItem(title: 'Detalles', link: '/accounts', icon: Icons.info_outline),
];

const List<HomeMenuItem> homeMenuItems = [
  HomeMenuItem(title: 'Home', icon: Icons.home_outlined, link: '/home'),
  HomeMenuItem(title: 'Transfers', icon: Icons.swap_horiz_outlined, link: '/transfers'),
  HomeMenuItem(title: 'Cards', icon: Icons.credit_card_outlined, link: '/cards'),
  HomeMenuItem(title: 'Reports', icon: Icons.insert_chart_outlined, link: '/reports'),
  HomeMenuItem(title: 'Configuration', icon: Icons.settings_outlined, link: '/configuration'),
];