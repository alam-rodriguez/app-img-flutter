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
    apiKey: 'AIzaSyCpveg0tQQ3hAkAR7TagzpYPnTWfeWgCb4',
    appId: '1:1085210063482:web:22d3a3b15f853534ca01c3',
    messagingSenderId: '1085210063482',
    projectId: 'flutter-test-2784a',
    authDomain: 'flutter-test-2784a.firebaseapp.com',
    storageBucket: 'flutter-test-2784a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClNhbfOV7Bm-GcpHAu5cOceiAUgso9vEo',
    appId: '1:1085210063482:android:bdb4224f2b2e5f0fca01c3',
    messagingSenderId: '1085210063482',
    projectId: 'flutter-test-2784a',
    storageBucket: 'flutter-test-2784a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCE8Sx2wmk7RxCoKdaj5cEg1oeVNa9iH88',
    appId: '1:1085210063482:ios:a40a658878c9af09ca01c3',
    messagingSenderId: '1085210063482',
    projectId: 'flutter-test-2784a',
    storageBucket: 'flutter-test-2784a.appspot.com',
    iosClientId: '1085210063482-0c37q05br92p9p7rp5is6fpti0keh3e3.apps.googleusercontent.com',
    iosBundleId: 'com.example.imgApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCE8Sx2wmk7RxCoKdaj5cEg1oeVNa9iH88',
    appId: '1:1085210063482:ios:63908c742bd38588ca01c3',
    messagingSenderId: '1085210063482',
    projectId: 'flutter-test-2784a',
    storageBucket: 'flutter-test-2784a.appspot.com',
    iosClientId: '1085210063482-ah8kfiueuggk1g8nscu76o9lon5imdef.apps.googleusercontent.com',
    iosBundleId: 'com.example.imgApp.RunnerTests',
  );
}
