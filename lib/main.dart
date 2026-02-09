import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/about_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/home_screen.dart';
import 'theme/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyPortfolioApp(),
    ),
  );
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Sagar Kalel - Arts',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme,
          themeMode: ThemeMode.system,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/gallery': (context) => const GalleryScreen(),
            '/about': (context) => const AboutScreen(),
          },
        );
      },
    );
  }
}
