import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';
import '../utils/responsive_util.dart';
import '../widgets/custom_nav_bar.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtil.isMobile(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.getBackgroundColor(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavBar(currentRoute: '/about'),
            _buildHeader(isMobile, themeProvider),
            _buildAboutContent(isMobile, themeProvider),
            _buildFooter(isMobile, themeProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile, ThemeProvider themeProvider) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: ResponsiveUtil.getResponsivePadding(context),
        child: Column(
          children: [
            SizedBox(height: isMobile ? 40 : 60),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(scale: value, child: child);
              },
              child: Text(
                'ABOUT',
                style: TextStyle(
                  fontSize: isMobile ? 48 : 72,
                  fontWeight: FontWeight.w900,
                  letterSpacing: isMobile ? 4 : 8,
                  color: themeProvider.getTextColor(context),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: isMobile ? 60 : 80,
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D)],
                ),
              ),
            ),
            SizedBox(height: isMobile ? 40 : 60),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutContent(bool isMobile, ThemeProvider themeProvider) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: ResponsiveUtil.getResponsivePadding(context),
          child: Center(
            child: Column(
              children: [
                // Animated icon
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Transform.rotate(
                        angle: (1 - value) * 3.14,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(isMobile ? 24 : 32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFF6B6B).withOpacity(0.1),
                          const Color(0xFFFFE66D).withOpacity(0.1),
                        ],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFF6B6B).withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.brush,
                      size: isMobile ? 60 : 80,
                      color: const Color(0xFFFF6B6B),
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 30 : 40),

                // Coming soon text
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    'Coming Soon',
                    style: TextStyle(
                      fontSize: isMobile ? 32 : 48,
                      fontWeight: FontWeight.w700,
                      color: themeProvider.getTextColor(context),
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 16 : 20),

                // Description
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(opacity: value, child: child);
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      'More information will be added here soon.\nFor now, enjoy exploring the gallery!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 18,
                        color: themeProvider.getSecondaryTextColor(context),
                        height: 1.8,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 40 : 60),

                // CTA Button
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/gallery'),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 32 : 48,
                          vertical: isMobile ? 16 : 20,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D)],
                          ),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF6B6B).withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'VIEW GALLERY',
                              style: TextStyle(
                                fontSize: isMobile ? 14 : 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: isMobile ? 8 : 12),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: isMobile ? 18 : 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(bool isMobile, ThemeProvider themeProvider) {
    return Container(
      margin: const EdgeInsets.only(top: 80),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: isMobile ? 30 : 40,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: themeProvider.getBorderColor(context),
            width: 1,
          ),
        ),
      ),
      child: Text(
        '© 2026 Sagar Kalel. All rights reserved.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isMobile ? 12 : 14,
          color: themeProvider.getSecondaryTextColor(context),
          letterSpacing: 1,
        ),
      ),
    );
  }
}
