# Premium Unit Converter App

A beautiful, production-ready Unit Converter application built with Flutter featuring a premium Neumorphic design.

## Features

### 🎨 Premium UI/UX Design
- **Neumorphic Design Language**: Modern, soft UI with smooth shadows and depth
- **Light/Dark Mode**: Seamless theme toggle with beautiful color palettes
- **Smooth Animations**: Fluid transitions between categories and states
- **Haptic Feedback**: Tactile response on key interactions
- **Responsive Layout**: Works perfectly on all screen sizes

### 📐 Comprehensive Unit Categories
1. **Weight & Mass**: kg, g, mg, Metric Tons, lb, oz
2. **Length & Distance**: m, km, cm, mm, Miles, Yards, Feet, Inches
3. **Volume & Capacity**: L, mL, Cubic Meters, Gallons (US/UK), Quarts, Pints, Cups
4. **Temperature**: Celsius, Fahrenheit, Kelvin
5. **Area**: m², km², cm², Hectares, Acres, mi², yd², ft², in²
6. **Speed**: m/s, km/h, mph, Knots, ft/s

### ⚡ Core Functionality
- **Real-time Conversion**: Instant calculation as you type
- **Swap Function**: Quick button to reverse From/To units
- **Copy to Clipboard**: One-tap copy of converted results
- **High Precision**: Up to 10 decimal places accuracy
- **Smart Formatting**: Automatic trailing zero removal

## Getting Started

### Prerequisites
- Flutter SDK (3.19.0 or higher)
- Android Studio / VS Code
- Android SDK (for APK build)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd unit_converter
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Building APK via GitHub Actions

This project includes a GitHub Actions workflow that automatically builds the Android APK when you push to the `main` branch.

### Steps:
1. Push your code to GitHub:
```bash
git add .
git commit -m "Initial commit"
git push origin main
```

2. Go to your GitHub repository → Actions tab

3. Wait for the "Build APK" workflow to complete

4. Download the APK from the artifacts section

### Manual Build:
```bash
flutter build apk --release
```

The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── unit_models.dart      # Data models for units
│   └── unit_data.dart        # Unit conversion data
├── providers/
│   ├── converter_provider.dart  # Conversion logic & state
│   └── theme_provider.dart      # Theme management
├── screens/
│   └── home_screen.dart      # Main UI screen
└── widgets/
    ├── category_card.dart    # Category selection cards
    └── unit_selector.dart    # Unit dropdown selectors

.github/
└── workflows/
    └── build-apk.yml         # GitHub Actions workflow
```

## Dependencies

- **provider**: State management
- **flutter_neumorphic**: Neumorphic design components
- **font_awesome_flutter**: Premium icons
- **google_fonts**: Beautiful typography
- **glassmorphism**: Glass effect components
- **vibration**: Haptic feedback
- **clipboard**: Copy to clipboard functionality

## Screenshots

The app features:
- Beautiful gradient category cards
- Smooth neumorphic input fields
- Real-time result display with gradient background
- One-tap copy functionality
- Theme toggle with sun/moon icon

## License

This project is open source and available under the MIT License.

## Support

If you encounter any issues, please open an issue on GitHub.
