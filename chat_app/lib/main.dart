import 'package:chat_app/auth_providers.dart'; // Import the new provider
import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/screens/splash.dart';
import 'package:chat_app/screens/profile_verification.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // No longer directly needed here
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope( // Wrap with ProviderScope
      child: App(),
    ),
  );
}

class App extends ConsumerWidget { // Change to ConsumerWidget
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Add WidgetRef
    final authState = ref.watch(authStateChangesProvider); // Watch the provider

    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 63, 17, 177),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shadowColor: Colors.black.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shadowColor: Colors.black.withValues(alpha: 0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.withValues(alpha: 0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 63, 17, 177),
              width: 2,
            ),
          ),
        ),
      ),
      home: authState.when(
        data: (user) {
          if (user != null) {
            return const ProfileVerificationScreen(); // Show profile verification first
          }
          return const AuthScreen(); // User is not logged in
        },
        loading: () => const SplashScreen(), // Show splash screen while loading
        error: (error, stackTrace) {
          // Optionally handle error state, e.g., show an error screen
          return const AuthScreen(); // Fallback to AuthScreen on error
        },
      ),
    );
  }
}
