import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF161622),

    // BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF161622),
      selectedItemColor: Color(0xFF0066FF),
      unselectedItemColor: Color(0xFFA2A2A7),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF161622),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFA2A2A7)),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: IconThemeData(color: Color(0xFF0066FF)),
    ),
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: const Color(0xFF232533),
      indicatorColor: const Color.fromARGB(255, 62, 62, 108),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(color: Colors.white),
      ),
      iconTheme: WidgetStateProperty.all(
        const IconThemeData(color: Color(0xFFA2A2A7)),
      ),
    ),
  );
}
