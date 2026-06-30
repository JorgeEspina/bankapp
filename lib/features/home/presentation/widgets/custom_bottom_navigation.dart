import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bankapp/core/l10n/app_localizations.dart';
import '../../config/menu/home_menu_items.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final menuItems = getHomeMenuItems();
    final location = GoRouter.of(context).location;

    final currentIndex = menuItems.indexWhere(
      (item) => item.link == location,
    );

    return BottomNavigationBar(
      currentIndex: currentIndex < 0 ? 0 : currentIndex,
      items: menuItems
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.getTitle(l10n),
            ),
          )
          .toList(),
      onTap: (index) {
        final link = menuItems[index].link;
        if (link != null) {
          context.go(link);
        }
      },
    );
  }
}
