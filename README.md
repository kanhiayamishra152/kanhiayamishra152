# Unit Converter App

A premium Flutter-based Unit Converter Application with modern Neumorphic design, supporting multiple unit categories with high-precision conversion.

## Features

### 🎨 Premium UI/UX Design
- **Neumorphic Design**: Modern, soft UI with smooth shadows and gradients
- **Light/Dark Mode**: Seamless theme toggle with animated transitions
- **Responsive Layout**: Works perfectly on all screen sizes
- **Haptic Feedback**: Tactile response on interactions (where supported)
- **Smooth Animations**: Beautiful transitions between categories

### 📊 Unit Categories
1. **Weight & Mass**: kg, g, mg, metric tons, lb, oz
2. **Length & Distance**: m, km, cm, mm, miles, yards, ft, inches
3. **Volume & Capacity**: L, mL, m³, gallons (US/UK), quarts, pints, cups
4. **Temperature**: Celsius, Fahrenheit, Kelvin
5. **Area**: m², km², cm², mm², hectares, acres, mi², yd², ft², in²
6. **Speed**: m/s, km/h, mph, knots, ft/s

### ⚡ Core Functionality
- **Real-time Conversion**: Instant calculation as you type
- **Swap Button**: Quick reversal of from/to units
- **Copy to Clipboard**: One-tap copy of results
- **High Precision**: Up to 10 decimal places accuracy
- **Category Selection**: Easy horizontal scrollable category cards

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── unit_model.dart       # Unit data model
├── providers/
│   └── converter_provider.dart  # State management
├── screens/
│   └── home_screen.dart      # Main UI screen
├── utils/
│   ├── conversion_logic.dart     # Conversion algorithms
│   └── unit_data_provider.dart   # Unit definitions
└── widgets/
    ├── category_selector.dart    # Category selection widget
    ├── conversion_card.dart      # Input/output card widget
    └── theme_toggle.dart         # Dark/Light mode toggle

android/                    # Android platform files
.github/workflows/
└── build-apk.yml          # GitHub Actions CI/CD
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd unit_converter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build APK via GitHub Actions

The project includes a complete GitHub Actions workflow that automatically builds the APK:

1. Push your code to the `main` or `master` branch
2. GitHub Actions will automatically trigger the build
3. Download the APK from the "Actions" tab → Select workflow run → Download artifacts

Available APK variants:
- `app-armeabi-v7a-release.apk` (32-bit ARM)
- `app-arm64-v8a-release.apk` (64-bit ARM)
- `app-x86_64-release.apk` (64-bit x86)
- `app-universal-release.apk` (Universal - all architectures)

## Dependencies

- **provider**: ^6.1.1 - State management
- **flutter_neumorphic**: ^3.2.0 - Neumorphic design components
- **google_fonts**: ^6.1.0 - Beautiful typography
- **font_awesome_flutter**: ^10.6.0 - Icon library
- **clipboard**: ^0.1.3 - Copy to clipboard functionality
- **vibration**: ^1.8.4 - Haptic feedback
- **intl**: ^0.18.1 - Internationalization

## Screenshots

The app features:
- Clean, modern interface with category-based navigation
- Real-time conversion display
- Animated theme toggle
- Smooth card-based input/output sections

## License

This project is open source and available under the MIT License.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

Made with ❤️ using Flutter
