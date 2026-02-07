import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/artwork.dart';
import '../theme/theme_provider.dart';
import '../utils/responsive_util.dart';
import '../widgets/custom_nav_bar.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Artwork> artworks = Artwork.getSampleArtworks();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
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
            const CustomNavBar(currentRoute: '/gallery'),
            _buildHeader(isMobile, themeProvider),
            _buildGalleryGrid(isMobile, themeProvider),
            _buildFooter(isMobile, themeProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile, ThemeProvider themeProvider) {
    return FadeTransition(
      opacity: _controller,
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
                'GALLERY',
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
            SizedBox(height: isMobile ? 16 : 24),
            Text(
              'A collection of my hand-drawn sketches',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.5,
                color: themeProvider.getSecondaryTextColor(context),
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Text(
              '${artworks.length} artworks',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                color: const Color(0xFFFF6B6B),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: isMobile ? 30 : 40),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryGrid(bool isMobile, ThemeProvider themeProvider) {
    final columns = ResponsiveUtil.getGridColumns(context);
    final spacing = isMobile ? 16.0 : 24.0;

    return Container(
      padding: ResponsiveUtil.getResponsivePadding(context),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: List.generate(artworks.length, (index) {
              return _buildArtworkCard(
                artworks[index],
                (constraints.maxWidth - (spacing * (columns - 1))) / columns,
                isMobile,
                index,
                themeProvider,
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildArtworkCard(
    Artwork artwork,
    double width,
    bool isMobile,
    int index,
    ThemeProvider themeProvider,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _showArtworkDetail(artwork, themeProvider),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: themeProvider.getSurfaceColor(context),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: themeProvider.getBorderColor(context),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    themeProvider.isDarkMode ? 0.2 : 0.05,
                  ),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with indicator for multiple images
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        artwork.images[0],
                        fit: BoxFit.cover,
                        width: width,
                        height: width * 1.2,
                        errorBuilder: (ctx, e, s) => Container(
                          width: width,
                          height: width * 1.2,
                          decoration: BoxDecoration(
                            color: themeProvider.getSurfaceColor(context),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: isMobile ? 40 : 60,
                                  color: themeProvider.getSecondaryTextColor(
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Add Image Here',
                                  style: TextStyle(
                                    fontSize: isMobile ? 12 : 14,
                                    color: themeProvider.getSecondaryTextColor(
                                      context,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Multiple images indicator
                    if (artwork.images.length > 1)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.collections,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${artwork.images.length}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),

                // Info section
                Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artwork.title,
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.w600,
                          color: themeProvider.getTextColor(context),
                          letterSpacing: 0.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (artwork.tags.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: artwork.tags.take(3).map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF6B6B).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '#$tag',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFF6B6B),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showArtworkDetail(Artwork artwork, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (context) =>
          ArtworkDetailDialog(artwork: artwork, themeProvider: themeProvider),
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

// Artwork Detail Dialog with image carousel and zoom functionality
class ArtworkDetailDialog extends StatefulWidget {
  final Artwork artwork;
  final ThemeProvider themeProvider;

  const ArtworkDetailDialog({
    super.key,
    required this.artwork,
    required this.themeProvider,
  });

  @override
  State<ArtworkDetailDialog> createState() => _ArtworkDetailDialogState();
}

class _ArtworkDetailDialogState extends State<ArtworkDetailDialog> {
  late PageController _pageController;
  late TransformationController _transformationController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtil.isMobile(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(isMobile ? 16 : 40),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isMobile ? double.infinity : 1000,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button and reset zoom button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Reset zoom button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _resetZoom,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: widget.themeProvider.getSurfaceColor(context),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.zoom_out_map,
                        color: widget.themeProvider.getTextColor(context),
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Close button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: widget.themeProvider.getSurfaceColor(context),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.close,
                        color: widget.themeProvider.getTextColor(context),
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Image carousel with zoom
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: widget.themeProvider.getSurfaceColor(context),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                            _resetZoom(); // Reset zoom when changing pages
                          });
                        },
                        itemCount: widget.artwork.images.length,
                        itemBuilder: (context, index) {
                          return InteractiveViewer(
                            transformationController: _transformationController,
                            minScale: 0.5,
                            maxScale: 4.0,
                            boundaryMargin: const EdgeInsets.all(20),
                            clipBehavior: Clip.none,
                            child: Center(
                              child: Image.asset(
                                widget.artwork.images[index],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                      Icons.image_outlined,
                                      size: 100,
                                      color: widget.themeProvider
                                          .getSecondaryTextColor(context),
                                    ),
                              ),
                            ),
                          );
                        },
                      ),

                      // Navigation arrows
                      if (widget.artwork.images.length > 1) ...[
                        if (_currentPage > 0)
                          Positioned(
                            left: 16,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: _buildNavigationButton(
                                Icons.arrow_back_ios_new,
                                () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              ),
                            ),
                          ),
                        if (_currentPage < widget.artwork.images.length - 1)
                          Positioned(
                            right: 16,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: _buildNavigationButton(
                                Icons.arrow_forward_ios,
                                () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              ),
                            ),
                          ),
                      ],

                      // Page indicator
                      if (widget.artwork.images.length > 1)
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  widget.artwork.images.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    width: index == _currentPage ? 24 : 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: index == _currentPage
                                          ? const Color(0xFFFF6B6B)
                                          : Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Zoom hint overlay
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.zoom_in,
                                size: 16,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Pinch or scroll to zoom',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Info section
            Container(
              padding: EdgeInsets.all(isMobile ? 20 : 28),
              decoration: BoxDecoration(
                color: widget.themeProvider.getSurfaceColor(context),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: widget.themeProvider.getBorderColor(context),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.artwork.title,
                    style: TextStyle(
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.w700,
                      color: widget.themeProvider.getTextColor(context),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.artwork.description,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: widget.themeProvider.getSecondaryTextColor(
                        context,
                      ),
                      height: 1.6,
                    ),
                  ),
                  if (widget.artwork.tags.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.artwork.tags
                          .map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: widget.themeProvider.getSurfaceColor(
                                  context,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: widget.themeProvider.getBorderColor(
                                    context,
                                  ),
                                ),
                              ),
                              child: Text(
                                '#$tag',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: widget.themeProvider
                                      .getSecondaryTextColor(context),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D)],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6B6B).withOpacity(0.4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
