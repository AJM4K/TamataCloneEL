import 'package:flutter/material.dart';

ThemeData ThemeInfo() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.red,
    hintColor: const Color.fromARGB(255, 255, 111, 111),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.redAccent,
      selectedItemColor: const Color.fromARGB(255, 255, 75, 75),
      unselectedItemColor:
          const Color.fromARGB(255, 163, 163, 163).withOpacity(.60),
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
  );
}
