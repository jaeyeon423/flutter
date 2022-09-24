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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0SOx-2EaWQdx9mBML0y5gbk5sGQEGShE',
    appId: '1:506411586069:android:5e019cafab63182383741c',
    messagingSenderId: '506411586069',
    projectId: 'hair-booking-922dc',
    databaseURL: 'https://hair-booking-922dc-default-rtdb.firebaseio.com',
    storageBucket: 'hair-booking-922dc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8SRyNtcj6lRQz-uyfSKf3zZIyr8FD9nE',
    appId: '1:506411586069:ios:f5b7c1dca375019883741c',
    messagingSenderId: '506411586069',
    projectId: 'hair-booking-922dc',
    databaseURL: 'https://hair-booking-922dc-default-rtdb.firebaseio.com',
    storageBucket: 'hair-booking-922dc.appspot.com',
    iosClientId: '506411586069-m7f1ode00s6l69jt8f4kuoorv2uolaol.apps.googleusercontent.com',
    iosBundleId: 'com.example.byc',
  );
}
