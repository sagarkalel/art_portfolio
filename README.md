# Sagar Kalel - Art Portfolio

A modern, responsive Flutter web portfolio showcasing hand-drawn sketches and artwork with beautiful animations and theme support.

## ✨ Features

### 🎨 Core Features

- **Multi-Image Support**: Each artwork can have multiple images (carousel view)
- **Dark/Light Theme**: Toggle between dark and light modes
- **Fully Responsive**: Works seamlessly on mobile, tablet, and desktop
- **Beautiful Animations**:
  - Page transitions
  - Stagger animations
  - Floating elements
  - Pulse effects
  - Elastic transitions

### 📱 Pages

1. **Home**: Hero section with featured works and specialties
2. **Gallery**: Grid view of all artworks with filtering
3. **About**: Coming soon page with call-to-action

### 🎯 UI Highlights

- Modern gradient accents (Red to Yellow)
- Smooth page transitions
- Interactive hover effects
- Image carousel for multiple artwork images
- Tags for artworks
- Theme-aware colors throughout

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- A code editor (VS Code, Android Studio, etc.)

### Installation

1. **Clone or download the project**

2. **Install dependencies**

```bash
flutter pub get
```

3. **Run the app**

```bash
# For web
flutter run -d chrome

# For mobile/desktop
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point with theme provider
├── models/
│   └── artwork.dart         # Artwork model with multi-image support
├── screens/
│   ├── home_screen.dart     # Landing page
│   ├── gallery_screen.dart  # Gallery with filtering
│   └── about_screen.dart    # About page
├── widgets/
│   └── custom_nav_bar.dart  # Navigation bar with theme toggle
├── theme/
│   └── theme_provider.dart  # Theme management (dark/light)
└── utils/
    └── responsive_util.dart # Responsive helper functions
```

## 🖼️ Adding Your Artwork

### Method 1: Using the Artwork Model

Edit `lib/models/artwork.dart` and modify the `getSampleArtworks()` method:

```dart
Artwork(
  id: '1',
  title: 'Your Artwork Title',
  description: 'Description of your artwork',
  images: [
    'assets/images/your_image1.jpg',
    'assets/images/your_image2.jpg',  // Multiple images!
    'assets/images/your_image3.jpg',
  ],
  tags: ['portrait', 'sketch', 'pencil'],
),
```

### Method 2: Asset Setup

1. Create an `assets/images/` folder in your project root
2. Add your images to this folder
3. Update `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
```

4. Run `flutter pub get`

### Supported Image Formats

- JPG/JPEG
- PNG
- WebP
- GIF (static)

## 🎨 Customization

### Change Theme Colors

Edit `lib/theme/theme_provider.dart`:

```dart
// Change gradient colors
const Color(0xFFFF6B6B)  // Primary red
const Color(0xFFFFE66D)  // Secondary yellow
```

### Adjust Animations

Each screen has animation controllers you can customize:

- Duration: `Duration(milliseconds: 1000)`
- Curves: `Curves.easeOut`, `Curves.elasticOut`, etc.

### Responsive Breakpoints

Edit `lib/utils/responsive_util.dart`:

```dart
static bool isMobile(BuildContext context) =>
    MediaQuery.of(context).size.width < 600;  // Adjust this value

static bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= 600 &&
    MediaQuery.of(context).size.width < 1024;  // Adjust this value
```

## 🌟 Key Features Explained

### Multi-Image Artwork Support

Each artwork can have multiple images that display in a carousel:

- Swipe/Click to navigate between images
- Animated page indicators
- Navigation arrows on desktop
- Image count badge on gallery cards

### Theme Toggle

Users can switch between dark and light themes:

- Persists across navigation
- Smooth color transitions
- Theme-aware components throughout

### Responsive Grid

Automatically adjusts columns based on screen size:

- Mobile: 1 column
- Tablet: 2 columns
- Desktop: 3 columns

## 🔧 Build for Production

### Web

```bash
flutter build web --release
```

Output will be in `build/web/`

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

## 📝 TODO / Future Enhancements

- [ ] Add actual image loading from assets
- [ ] Implement image zoom/lightbox
- [ ] Add contact form on About page
- [ ] Add social media links
- [ ] Implement search functionality
- [ ] Add animation preferences (reduce motion)
- [ ] Add artwork sharing feature
- [ ] Implement lazy loading for images
- [ ] Add SEO meta tags for web

## 🐛 Known Issues

- Images are currently placeholders - replace with actual artwork
- Poppins font family referenced but not included (use default or add font files)

## 📄 License

© 2026 Sagar Kalel. All rights reserved.

## 🤝 Contributing

This is a personal portfolio project, but suggestions and feedback are welcome!

---

**Built with ❤️ using Flutter**
