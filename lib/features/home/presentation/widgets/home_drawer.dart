import 'package:bankapp/features/home/config/menu/home_menu_items.dart';
import 'package:flutter/material.dart';

const homeMenuItems = <HomeMenuItem>[
  HomeMenuItem(title: 'Home', icon: Icons.home_outlined, link: '/home'),
  HomeMenuItem(title: 'Transfers', icon: Icons.swap_horiz_outlined, link: '/transfers'),
  HomeMenuItem(title: 'Payments', icon: Icons.payment_outlined, link: '/payments'),
  HomeMenuItem(title: 'Cards', icon: Icons.credit_card_outlined, link: '/cards'),
  HomeMenuItem(title: 'Reports', icon: Icons.insert_chart_outlined, link: '/reports'),

  // Item especial de logout
  HomeMenuItem(title: 'Cerrar sesión', icon: Icons.logout_outlined),
];