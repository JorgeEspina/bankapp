import 'package:flutter/material.dart';
import 'package:bankapp/core/l10n/app_localizations.dart';

class HomeMenuItem {
  final String Function(AppLocalizations l10n) titleBuilder;
  final IconData icon;
  final String? link;

  const HomeMenuItem({
    required this.titleBuilder,
    required this.icon,
    this.link,
  });

  String getTitle(AppLocalizations l10n) => titleBuilder(l10n);
}

List<HomeMenuItem> getAccountActions() => [
      HomeMenuItem(
          titleBuilder: (l10n) => l10n.transfer,
          link: '/transfers',
          icon: Icons.swap_horiz),
      HomeMenuItem(
          titleBuilder: (l10n) => l10n.payments,
          link: '/payments',
          icon: Icons.payment_outlined),
      HomeMenuItem(
          titleBuilder: (l10n) => l10n.details,
          link: '/accounts',
          icon: Icons.info_outline),
    ];

List<HomeMenuItem> getHomeMenuItems() => [
      HomeMenuItem(
          titleBuilder: (l10n) => l10n.home,
          icon: Icons.home_outlined,
          link: '/home'),
      HomeMenuItem(
          titleBuilder: (l10n) => l10n.transfers,
          icon: Icons.swap_horiz_outlined,
          link: '/transfers'),
      HomeMenuItem(
          titleBuilder: (l10n) => l10n.cards,
          icon: Icons.credit_card_outlined,
          link: '/cards'),
      HomeMenuItem(
          titleBuilder: (l10n) => l10n.reports,
          icon: Icons.insert_chart_outlined,
          link: '/reports'),
      HomeMenuItem(
          titleBuilder: (l10n) => l10n.configuration,
          icon: Icons.settings_outlined,
          link: '/configuration'),
    ];
