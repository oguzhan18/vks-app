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
      apiKey: "AIzaSyADART70-Tr-23Rrb-RKnh0HFZhqh1KdLE",
      authDomain: "expenses-history.firebaseapp.com",
      databaseURL:
          "https://expenses-history-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "expenses-history",
      storageBucket: "expenses-history.appspot.com",
      messagingSenderId: "578225100300",
      appId: "1:578225100300:web:96630dccf7db46146dc029",
      measurementId: "G-1D2RMW5H38");

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: "AIzaSyADART70-Tr-23Rrb-RKnh0HFZhqh1KdLE",
      authDomain: "expenses-history.firebaseapp.com",
      databaseURL:
          "https://expenses-history-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "expenses-history",
      storageBucket: "expenses-history.appspot.com",
      messagingSenderId: "578225100300",
      appId: "1:578225100300:web:96630dccf7db46146dc029",
      measurementId: "G-1D2RMW5H38");

  static const FirebaseOptions ios = FirebaseOptions(
      apiKey: "AIzaSyADART70-Tr-23Rrb-RKnh0HFZhqh1KdLE",
      authDomain: "expenses-history.firebaseapp.com",
      databaseURL:
          "https://expenses-history-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "expenses-history",
      storageBucket: "expenses-history.appspot.com",
      messagingSenderId: "578225100300",
      appId: "1:578225100300:web:96630dccf7db46146dc029",
      measurementId: "G-1D2RMW5H38");

  static const FirebaseOptions macos = FirebaseOptions(
      apiKey: "AIzaSyADART70-Tr-23Rrb-RKnh0HFZhqh1KdLE",
      authDomain: "expenses-history.firebaseapp.com",
      databaseURL:
          "https://expenses-history-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "expenses-history",
      storageBucket: "expenses-history.appspot.com",
      messagingSenderId: "578225100300",
      appId: "1:578225100300:web:96630dccf7db46146dc029",
      measurementId: "G-1D2RMW5H38");
}