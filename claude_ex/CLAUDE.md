# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a standard Flutter application created with `flutter create`. The project follows Flutter's default structure and conventions, using Material Design components.

## Essential Commands

### Development
- `flutter run` - Run the app on connected device/emulator with hot reload
- `flutter run --debug` - Run in debug mode (default)
- `flutter run --release` - Run optimized release build
- `flutter run --profile` - Run in profile mode for performance analysis

### Building
- `flutter build apk` - Build Android APK
- `flutter build appbundle` - Build Android App Bundle for Play Store
- `flutter build ios` - Build iOS app (requires macOS and Xcode)
- `flutter build web` - Build web version
- `flutter build windows` - Build Windows desktop app
- `flutter build macos` - Build macOS desktop app
- `flutter build linux` - Build Linux desktop app

### Testing and Quality
- `flutter test` - Run all unit and widget tests
- `flutter test test/widget_test.dart` - Run specific test file
- `flutter analyze` - Static analysis using rules from analysis_options.yaml
- `flutter doctor` - Check Flutter installation and dependencies

### Maintenance
- `flutter clean` - Clean build artifacts and caches
- `flutter pub get` - Install dependencies from pubspec.yaml
- `flutter pub upgrade` - Upgrade packages to latest compatible versions
- `flutter pub outdated` - Check for outdated dependencies

## Project Structure

### Key Directories
- `lib/` - Main Dart source code
  - `main.dart` - Application entry point with MyApp and MyHomePage widgets
- `test/` - Unit and widget tests
- `android/` - Android-specific configuration and build files
- `ios/` - iOS-specific configuration and build files
- `web/` - Web-specific assets and configuration
- `windows/`, `linux/`, `macos/` - Desktop platform configurations

### Configuration Files
- `pubspec.yaml` - Project configuration, dependencies, and metadata
- `analysis_options.yaml` - Dart analyzer configuration using flutter_lints
- `android/build.gradle.kts` - Android build configuration
- Platform-specific manifests and Info.plist files in respective directories

## Architecture

This is a basic Flutter counter app with:
- StatelessWidget (MyApp) for app configuration
- StatefulWidget (MyHomePage) for counter functionality
- Material Design theming with ColorScheme.fromSeed
- Standard Flutter project structure with multi-platform support

The app demonstrates fundamental Flutter concepts including state management with setState(), widget composition, and Material Design components.