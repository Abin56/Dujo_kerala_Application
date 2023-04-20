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
    apiKey: 'AIzaSyCvnr3tZft-N4oPk0g_StLM5-HaZYY2ws8',
    appId: '1:1019389632971:web:73f653f467a7d5dc06164e',
    messagingSenderId: '1019389632971',
    projectId: 'dujo-kerala-schools-1a6c5',
    authDomain: 'dujo-kerala-schools-1a6c5.firebaseapp.com',
    storageBucket: 'dujo-kerala-schools-1a6c5.appspot.com',
    measurementId: 'G-NBQ0J2X8HQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfP_OzJhm2Dr7XIe_xvXzP_QsbdsDemK4',
    appId: '1:1019389632971:android:c92299d71d542fab06164e',
    messagingSenderId: '1019389632971',
    projectId: 'dujo-kerala-schools-1a6c5',
    storageBucket: 'dujo-kerala-schools-1a6c5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsAZB-W_pgt1Sf07Nmb8Oi3mgAjrra0L4',
    appId: '1:1019389632971:ios:b41aa06411cb81ae06164e',
    messagingSenderId: '1019389632971',
    projectId: 'dujo-kerala-schools-1a6c5',
    storageBucket: 'dujo-kerala-schools-1a6c5.appspot.com',
    androidClientId: '1019389632971-1h818bij5go8q5t9ob99jvb2lbhv1nu1.apps.googleusercontent.com',
    iosClientId: '1019389632971-q3fbnncg1vav95pbgp6efj3g9i08kj4u.apps.googleusercontent.com',
    iosBundleId: 'com.example.dujoApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAsAZB-W_pgt1Sf07Nmb8Oi3mgAjrra0L4',
    appId: '1:1019389632971:ios:b41aa06411cb81ae06164e',
    messagingSenderId: '1019389632971',
    projectId: 'dujo-kerala-schools-1a6c5',
    storageBucket: 'dujo-kerala-schools-1a6c5.appspot.com',
    androidClientId: '1019389632971-1h818bij5go8q5t9ob99jvb2lbhv1nu1.apps.googleusercontent.com',
    iosClientId: '1019389632971-q3fbnncg1vav95pbgp6efj3g9i08kj4u.apps.googleusercontent.com',
    iosBundleId: 'com.example.dujoApplication',
  );
}
