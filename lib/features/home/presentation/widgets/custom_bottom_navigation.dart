import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF232533),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_horiz_outlined),
          label: 'Transfers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment_outlined),
          label: 'Payments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card_outlined),
          label: 'Cards',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart_outlined),
          label: 'Reports',
        ),
      ],
    );
  }
}
