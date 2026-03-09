import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/menu/home_menu_items.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {

    final location = GoRouter.of(context).location;

    final currentIndex = homeMenuItems.indexWhere(
      (item) => item.link == location,
    );

    return BottomNavigationBar(
      //backgroundColor: const Color(0xFF232533),
      currentIndex: currentIndex < 0 ? 0 : currentIndex,

      items: homeMenuItems
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.title,
            ),
          )
          .toList(),

      onTap: (index) {
        final link = homeMenuItems[index].link;

        if (link != null) {
          context.go(link);
        }
      },
    );
  }
}