// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members, depend_on_referenced_packages
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
      apiKey: "AIzaSyBymd_CbNB2Bn7qgM67E7vC_Y8ZwUsBal4",
      authDomain: "vks-app-f9b3e.firebaseapp.com",
      databaseURL:
          "https://vks-app-f9b3e-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "vks-app-f9b3e",
      storageBucket: "vks-app-f9b3e.appspot.com",
      messagingSenderId: "1089859076002",
      appId: "1:1089859076002:web:34b80d824ce480c5453cfb",
      measurementId: "G-KQ9TZBSRQK");

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: "AIzaSyBymd_CbNB2Bn7qgM67E7vC_Y8ZwUsBal4",
      authDomain: "vks-app-f9b3e.firebaseapp.com",
      databaseURL:
          "https://vks-app-f9b3e-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "vks-app-f9b3e",
      storageBucket: "vks-app-f9b3e.appspot.com",
      messagingSenderId: "1089859076002",
      appId: "1:1089859076002:web:34b80d824ce480c5453cfb",
      measurementId: "G-KQ9TZBSRQK");

  static const FirebaseOptions ios = FirebaseOptions(
      apiKey: "AIzaSyBymd_CbNB2Bn7qgM67E7vC_Y8ZwUsBal4",
      authDomain: "vks-app-f9b3e.firebaseapp.com",
      databaseURL:
          "https://vks-app-f9b3e-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "vks-app-f9b3e",
      storageBucket: "vks-app-f9b3e.appspot.com",
      messagingSenderId: "1089859076002",
      appId: "1:1089859076002:web:34b80d824ce480c5453cfb",
      measurementId: "G-KQ9TZBSRQK");

  static const FirebaseOptions macos = FirebaseOptions(
      apiKey: "AIzaSyBymd_CbNB2Bn7qgM67E7vC_Y8ZwUsBal4",
      authDomain: "vks-app-f9b3e.firebaseapp.com",
      databaseURL:
          "https://vks-app-f9b3e-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "vks-app-f9b3e",
      storageBucket: "vks-app-f9b3e.appspot.com",
      messagingSenderId: "1089859076002",
      appId: "1:1089859076002:web:34b80d824ce480c5453cfb",
      measurementId: "G-KQ9TZBSRQK");
}
