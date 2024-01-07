// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyADfzDiO6zMeiCEm5UTVhOqMSxWMd5erAI',
    appId: '1:776183779701:web:d04dcbb2878794d8da033c',
    messagingSenderId: '776183779701',
    projectId: 'flutter-chat-app-8c5c2',
    authDomain: 'flutter-chat-app-8c5c2.firebaseapp.com',
    storageBucket: 'flutter-chat-app-8c5c2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsoInn0gOAcBcbEjwE_75UrxhuRepLLSc',
    appId: '1:776183779701:android:b2e9369cf4e821e9da033c',
    messagingSenderId: '776183779701',
    projectId: 'flutter-chat-app-8c5c2',
    storageBucket: 'flutter-chat-app-8c5c2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2zF4odoQ7zkvVlZqpDsZS_hfsN5Q28GE',
    appId: '1:776183779701:ios:074b343e9a8787ddda033c',
    messagingSenderId: '776183779701',
    projectId: 'flutter-chat-app-8c5c2',
    storageBucket: 'flutter-chat-app-8c5c2.appspot.com',
    iosBundleId: 'com.example.chatFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2zF4odoQ7zkvVlZqpDsZS_hfsN5Q28GE',
    appId: '1:776183779701:ios:95849ee447a83fb7da033c',
    messagingSenderId: '776183779701',
    projectId: 'flutter-chat-app-8c5c2',
    storageBucket: 'flutter-chat-app-8c5c2.appspot.com',
    iosBundleId: 'com.example.chatFirebase.RunnerTests',
  );
}
