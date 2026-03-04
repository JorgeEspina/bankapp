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