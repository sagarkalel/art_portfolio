import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? _darkTheme : _lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Dark Theme
  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFFFF6B6B),
      secondary: const Color(0xFFFFE66D),
      surface: const Color(0xFF1a1a1a),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF0a0a0a),
    fontFamily: 'Poppins',
    cardTheme: CardThemeData(
      color: const Color(0xFF1a1a1a),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
    ),
  );

  // Light Theme
  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFFFF6B6B),
      secondary: const Color(0xFFFFE66D),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black87,
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    fontFamily: 'Poppins',
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  Color getBackgroundColor(BuildContext context) {
    return _isDarkMode ? const Color(0xFF0a0a0a) : const Color(0xFFF5F5F5);
  }

  Color getSurfaceColor(BuildContext context) {
    return _isDarkMode ? const Color(0xFF1a1a1a) : Colors.white;
  }

  Color getTextColor(BuildContext context) {
    return _isDarkMode ? Colors.white : Colors.black87;
  }

  Color getSecondaryTextColor(BuildContext context) {
    return _isDarkMode ? Colors.white.withOpacity(0.7) : Colors.black54;
  }

  Color getBorderColor(BuildContext context) {
    return _isDarkMode ? Colors.white.withOpacity(0.1) : Colors.black12;
  }
}
