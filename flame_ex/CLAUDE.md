# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter game development project using the Flame game engine. The project is set up with a basic Flame game structure ready for game development.

## Development Commands

### Essential Flutter Commands
- `flutter run` - Run the game in debug mode (supports hot reload)
- `flutter test` - Run all tests
- `flutter analyze` - Run static analysis and linting
- `flutter pub get` - Install dependencies
- `flutter build apk` - Build Android APK
- `flutter build web` - Build web version

### Testing
- `flutter test test/widget_test.dart` - Run the basic game loading test

## Project Structure

- `lib/main.dart` - Contains MyGame class extending FlameGame with basic game loop structure
- `test/widget_test.dart` - Basic game loading test
- `pubspec.yaml` - Includes Flame package dependency

## Flame Game Architecture

The main game class `MyGame` extends `FlameGame` and includes:
- `onLoad()` - Game initialization (called once)
- `update(double dt)` - Game loop update method (called every frame)

Game components should be added to the game world in the `onLoad()` method. Game logic updates go in the `update()` method.

## Code Quality

The project uses `flutter_lints` package with standard Flutter linting rules activated via `analysis_options.yaml`.