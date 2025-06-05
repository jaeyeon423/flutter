import 'package:chat_app/auth_providers.dart'; // Import the new provider
import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/splash.dart';
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
        ),
        useMaterial3: true,
      ),
      home: authState.when(
        data: (user) {
          if (user != null) {
            return const ChatScreen(); // User is logged in
          }
          return const AuthScreen(); // User is not logged in
        },
        loading: () => const SplashScreen(), // Show splash screen while loading
        error: (error, stackTrace) {
          // Optionally handle error state, e.g., show an error screen
          print('Auth State Error: $error');
          return const AuthScreen(); // Fallback to AuthScreen on error
        },
      ),
    );
  }
}
