import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';
import '../utils/responsive_util.dart';

class CustomNavBar extends StatefulWidget {
  final String currentRoute;

  const CustomNavBar({super.key, required this.currentRoute});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar>
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
      begin: const Offset(0, -0.5),
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

    return SafeArea(
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            padding: isMobile
                ? const EdgeInsets.symmetric(horizontal: 20, vertical: 16)
                : const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
            decoration: BoxDecoration(
              color: themeProvider.getSurfaceColor(context).withOpacity(0.95),
              border: Border(
                bottom: BorderSide(
                  color: themeProvider.getBorderColor(context),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLogo(isMobile, themeProvider),
                Row(
                  children: [
                    if (!isMobile) _buildDesktopNav(themeProvider),
                    SizedBox(width: isMobile ? 12 : 24),
                    _buildThemeToggle(themeProvider),
                    if (isMobile) ...[
                      const SizedBox(width: 12),
                      _buildMobileMenu(themeProvider),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isMobile, ThemeProvider themeProvider) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, '/'),
        child: Row(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: isMobile ? 14 : 20,
                    height: isMobile ? 14 : 20,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D)],
                      ),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF6B6B).withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            Text(
              'SAGAR KALEL',
              style: TextStyle(
                fontSize: isMobile ? 16 : 22,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                color: themeProvider.getTextColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopNav(ThemeProvider themeProvider) {
    return Row(
      children: [
        _buildNavItem('HOME', '/', themeProvider),
        const SizedBox(width: 40),
        _buildNavItem('GALLERY', '/gallery', themeProvider),
        const SizedBox(width: 40),
        _buildNavItem('ABOUT', '/about', themeProvider),
      ],
    );
  }

  Widget _buildNavItem(
    String label,
    String route,
    ThemeProvider themeProvider,
  ) {
    final isActive = widget.currentRoute == route;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (!isActive) {
            Navigator.pushReplacementNamed(context, route);
          }
        },
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: isActive ? 1.0 : 0.0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Container(
              padding: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.lerp(
                      Colors.transparent,
                      const Color(0xFFFF6B6B),
                      value,
                    )!,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  letterSpacing: 1.5,
                  color: Color.lerp(
                    themeProvider.getSecondaryTextColor(context),
                    themeProvider.getTextColor(context),
                    value,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildThemeToggle(ThemeProvider themeProvider) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => themeProvider.toggleTheme(),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Transform.rotate(
              angle: value * 6.28, // Full rotation
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: themeProvider.getSurfaceColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: themeProvider.getBorderColor(context),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF6B6B).withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: const Color(0xFFFF6B6B),
                  size: 20,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMobileMenu(ThemeProvider themeProvider) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.menu_rounded,
        color: themeProvider.getTextColor(context),
        size: 28,
      ),
      color: themeProvider.getSurfaceColor(context),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: themeProvider.getBorderColor(context)),
      ),
      onSelected: (route) {
        Navigator.pushReplacementNamed(context, route);
      },
      itemBuilder: (context) => [
        _buildMenuItem('HOME', '/', themeProvider),
        _buildMenuItem('GALLERY', '/gallery', themeProvider),
        _buildMenuItem('ABOUT', '/about', themeProvider),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(
    String label,
    String route,
    ThemeProvider themeProvider,
  ) {
    final isActive = widget.currentRoute == route;
    return PopupMenuItem(
      value: route,
      child: Row(
        children: [
          if (isActive)
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D)],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          if (isActive) const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: isActive
                  ? const Color(0xFFFF6B6B)
                  : themeProvider.getTextColor(context),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
