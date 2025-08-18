# GEMINI.md - sub_chat

## Project Overview

**sub_chat** is a Flutter-based mobile application designed to facilitate real-time, location-aware chat for subway passengers. The app identifies the user's proximity to subway stations and automatically displays chat rooms for nearby trains, allowing passengers on the same train to communicate with each other.

### Core Functionality

*   **Location-Based Chat Rooms:** Automatically creates and displays chat rooms for subway trains within a 100-meter radius of the user.
*   **Real-Time Updates:** Continuously monitors the user's location to provide an updated list of nearby train chat rooms.
*   **User Authentication:** Manages user sign-in and session persistence.
*   **Persistent Chat State:** Remembers the last chat room the user joined and provides a quick "reconnect" option.
*   **Temporary Chat:** Includes a general-purpose "temporary" chat room that is not tied to a specific location.

### Key Technologies

*   **Frontend:** Flutter
*   **Backend & Database:** Firebase (Authentication, Firestore, Storage, Messaging)
*   **Location Services:** `geolocator`, `permission_handler`
*   **State Management:** `StreamBuilder` for reactive UI updates based on authentication and chat room status.
*   **Networking:** `http` for API communication.

### Architectural Patterns

The project follows a standard Flutter application structure, with a clear separation of concerns:

*   **`lib/screens`**: Contains the UI for each distinct screen (e.g., login, chat room list, profile).
*   **`lib/services`**: Encapsulates business logic and communication with external services like Firebase and location APIs.
*   **`lib/models`**: Defines the data structures used throughout the application.
*   **`lib/widgets`**: Houses reusable UI components that are shared across multiple screens.
*   **`lib/main.dart`**: Serves as the application's entry point, handling initialization and theme configuration.

## Building and Running

### Prerequisites

*   Flutter SDK
*   A configured Firebase project with the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files placed in the appropriate directories.

### Key Commands

*   **Install Dependencies:**
    ```bash
    flutter pub get
    ```

*   **Run the Application:**
    ```bash
    flutter run
    ```

*   **Build the Application:**
    *   **Android:**
        ```bash
        flutter build apk
        ```
    *   **iOS:**
        ```bash
        flutter build ios
        ```

*   **Run Tests:**
    ```bash
    flutter test
    ```

## Development Conventions

### Coding Style

*   The project adheres to the standard Dart and Flutter style guides, enforced by the `flutter_lints` package.
*   Code is well-documented with inline comments and debug prints to trace execution flow.

### State Management

*   The application primarily uses `StreamBuilder` to manage and react to changes in authentication state and real-time data from Firebase.
*   `StatefulWidget` is used to manage local UI state within individual screens and widgets.

### Error Handling

*   Error handling is implemented using `try-catch` blocks, particularly for asynchronous operations like Firebase calls and API requests.
*   User-facing error messages are displayed using `SnackBar` and `AlertDialog` widgets.
