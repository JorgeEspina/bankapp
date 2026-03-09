import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({required this.isDarkMode});

  ThemeData getTheme() {
    return isDarkMode ? _darkTheme() : _lightTheme();
  }

  ThemeData _darkTheme() => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF161622),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF161622),
      selectedItemColor: Color(0xFF0066FF),
      unselectedItemColor: Color(0xFFA2A2A7),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

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

  ThemeData _lightTheme() => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Color.fromARGB(255, 4, 29, 67),

    textTheme: const TextTheme(
      titleMedium: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 9, 39, 171),
      selectedItemColor: Color.fromARGB(255, 24, 91, 193),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: const Color.fromARGB(255, 4, 24, 112),
      indicatorColor: const Color.fromARGB(255, 29, 65, 226),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(color: Colors.white),
      ),
      iconTheme: WidgetStateProperty.all(
        const IconThemeData(color: Color(0xFFA2A2A7)),
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 7, 21, 80),
      iconTheme: IconThemeData(color: Colors.black54),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
