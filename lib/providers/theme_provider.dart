import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFFE8ECF1),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFE8ECF1),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF2D3748)),
      titleTextStyle: TextStyle(
        color: Color(0xFF2D3748),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardColor: const Color(0xFFF5F7FA),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF667EEA),
      secondary: Color(0xFF764BA2),
      surface: Color(0xFFF5F7FA),
      background: Color(0xFFE8ECF1),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFF1A202C),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1A202C),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFE2E8F0)),
      titleTextStyle: TextStyle(
        color: Color(0xFFE2E8F0),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardColor: const Color(0xFF2D3748),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF667EEA),
      secondary: Color(0xFF764BA2),
      surface: Color(0xFF2D3748),
      background: Color(0xFF1A202C),
    ),
  );
}
