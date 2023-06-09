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
    apiKey: 'AIzaSyBPaQ4Ga-d_wTd9pCiU_kMTllMeuVblSP0',
    appId: '1:512252187081:web:29a9843fc66f17bc6f5818',
    messagingSenderId: '512252187081',
    projectId: 'leptondujokerala',
    authDomain: 'leptondujokerala.firebaseapp.com',
    storageBucket: 'leptondujokerala.appspot.com',
    measurementId: 'G-QC6SR6TLE0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPYQ232se8EQjwRWXEyrpD6S280gIWh1w',
    appId: '1:512252187081:android:1ff4a847cb30eeea6f5818',
    messagingSenderId: '512252187081',
    projectId: 'leptondujokerala',
    storageBucket: 'leptondujokerala.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6NLxGfZp2jQxtGXWH-rlNb0zmguZYK-8',
    appId: '1:512252187081:ios:1d8e4087fc57b46b6f5818',
    messagingSenderId: '512252187081',
    projectId: 'leptondujokerala',
    storageBucket: 'leptondujokerala.appspot.com',
    iosClientId: '512252187081-l7s9amrdki7u3o9gom1qr4nbg9b04afi.apps.googleusercontent.com',
    iosBundleId: 'com.example.dujoKeralaApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6NLxGfZp2jQxtGXWH-rlNb0zmguZYK-8',
    appId: '1:512252187081:ios:1d8e4087fc57b46b6f5818',
    messagingSenderId: '512252187081',
    projectId: 'leptondujokerala',
    storageBucket: 'leptondujokerala.appspot.com',
    iosClientId: '512252187081-l7s9amrdki7u3o9gom1qr4nbg9b04afi.apps.googleusercontent.com',
    iosBundleId: 'com.example.dujoKeralaApplication',
  );
}
