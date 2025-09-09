# Application Features

This document provides a detailed overview of the core features implemented in the Sub Chat application.

## 1. User Authentication and Session Persistence

**Purpose:**
To manage user sign-up, sign-in, sign-out, and maintain a persistent login state across app sessions.

**Core Components:**
-   `services/auth_service.dart`: Handles all authentication logic with Firebase Auth.
-   `screens/login_screen.dart`: Provides the UI for user login and registration.
-   `main.dart` (`AuthWrapper`): Determines the initial screen (Login or Main) based on the user's authentication state.

**Mechanism:**
-   The app uses Firebase Authentication (Email/Password and Google Sign-In).
-   Upon successful login, Firebase Auth securely stores a long-lived **Refresh Token** on the device.
-   When the app restarts, the Firebase SDK uses this Refresh Token to automatically get a new short-lived **ID Token**, seamlessly re-authenticating the user.
-   The `AuthWrapper` widget listens to `AuthService.authStateChanges` stream to react to these state changes and direct the user to the appropriate screen, eliminating the need for repeated logins.

## 2. Real-time Chat

**Purpose:**
To enable users within the same chat room to send and receive messages in real-time.

**Core Components:**
-   `services/chat_service.dart`: Manages all chat-related Firestore operations (sending messages, fetching messages).
-   `screens/chat_room_screen.dart`: The UI for a specific chat room, displaying messages and the message input field.
-   `widgets/enhanced_message_input.dart`: The input component for typing and sending messages.
-   `widgets/message_bubble.dart`: The widget used to display individual chat messages.
-   `models/message_model.dart`: The data model for a chat message.

**Mechanism:**
-   Messages are stored in a `messages` subcollection within each chat room's document in Firestore.
-   `ChatService` provides a stream of messages (`getMessagesStream`) from a specific chat room.
-   `ChatRoomScreen` uses a `StreamBuilder` to listen to this stream and automatically rebuilds the message list whenever a new message is added to Firestore, resulting in a real-time experience.

## 3. Location-Based Chat Room Discovery

**Purpose:**
To automatically find and display chat rooms for subway trains that are physically near the user.

**Core Components:**
-   `services/location_service.dart`: Handles requesting location permissions and getting the user's current GPS coordinates using the `geolocator` package.
-   `services/subway_service.dart`: Fetches subway station information and calculates distances to find nearby stations.
-   `services/subway_cache_service.dart`: Caches subway station data to minimize API calls.
-   `screens/chat_room_list_screen.dart`: Displays the list of available chat rooms based on the user's location.

**Mechanism:**
1.  The app requests location permissions from the user.
2.  `LocationService` retrieves the user's current latitude and longitude.
3.  `SubwayService` uses these coordinates to identify all subway stations within a 100-meter radius.
4.  For each nearby station, the app queries for active train chat rooms associated with that station.
5.  The `ChatRoomListScreen` displays these dynamically discovered chat rooms to the user.

## 4. Profile Management

**Purpose:**
To allow users to view and update their profile information, such as their display name and password.

**Core Components:**
-   `screens/profile_screen.dart`: Provides the UI for displaying and editing profile information.
-   `services/auth_service.dart`: Contains the methods (`updateDisplayName`, `updatePassword`) to update user data in Firebase Auth and Firestore.

**Mechanism:**
-   The `ProfileScreen` displays the current user's information fetched from `AuthService.currentUser`.
-   When a user updates their display name, `AuthService.updateDisplayName` is called, which updates the profile in both Firebase Auth and the user's document in the `users` collection in Firestore.
-   Password changes are handled securely by re-authenticating the user with their current password before allowing an update.

## 5. User Blocking and Reporting System

**Purpose:**
To provide users with tools to maintain a safe and positive chat environment by blocking or reporting other users.

**Core Components:**
-   `services/block_service.dart`: Manages the logic for blocking and unblocking users.
-   `services/report_service.dart`: Handles the creation of user reports in Firestore.
-   `widgets/block_dialog.dart`: A confirmation dialog for blocking a user.
-   `widgets/report_dialog.dart`: A dialog for submitting a report against a user.

**Mechanism:**
-   **Blocking**: When User A blocks User B, User B's UID is added to a `blockedUsers` list in User A's user document in Firestore. The chat message stream is then filtered to exclude messages from any UID present in this list.
-   **Reporting**: When a user is reported, a new document is created in a `reports` collection in Firestore. This document contains the UID of the reporter, the UID of the reported user, the reason for the report, and a timestamp. This allows for administrative review.
