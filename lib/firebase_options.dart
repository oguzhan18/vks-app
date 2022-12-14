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
      apiKey: "AIzaSyBTLlFQWFMRlA5ltYje9G3judzodH_cGlY",
      authDomain: "vdk-app-841f5.firebaseapp.com",
      databaseURL:
          "https://vdk-app-841f5-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "vdk-app-841f5",
      storageBucket: "vdk-app-841f5.appspot.com",
      messagingSenderId: "492968715847",
      appId: "1:492968715847:web:eff6a12954588985b43362",
      measurementId: "G-P03TCWX8SB");

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: "AIzaSyBTLlFQWFMRlA5ltYje9G3judzodH_cGlY",
      authDomain: "vdk-app-841f5.firebaseapp.com",
      databaseURL:
          "https://vdk-app-841f5-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "vdk-app-841f5",
      storageBucket: "vdk-app-841f5.appspot.com",
      messagingSenderId: "492968715847",
      appId: "1:492968715847:web:eff6a12954588985b43362",
      measurementId: "G-P03TCWX8SB");

  static const FirebaseOptions ios = FirebaseOptions(
      apiKey: "AIzaSyBTLlFQWFMRlA5ltYje9G3judzodH_cGlY",
      authDomain: "vdk-app-841f5.firebaseapp.com",
      databaseURL:
          "https://vdk-app-841f5-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "vdk-app-841f5",
      storageBucket: "vdk-app-841f5.appspot.com",
      messagingSenderId: "492968715847",
      appId: "1:492968715847:web:eff6a12954588985b43362",
      measurementId: "G-P03TCWX8SB");

  static const FirebaseOptions macos = FirebaseOptions(
      apiKey: "AIzaSyBTLlFQWFMRlA5ltYje9G3judzodH_cGlY",
      authDomain: "vdk-app-841f5.firebaseapp.com",
      databaseURL:
          "https://vdk-app-841f5-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "vdk-app-841f5",
      storageBucket: "vdk-app-841f5.appspot.com",
      messagingSenderId: "492968715847",
      appId: "1:492968715847:web:eff6a12954588985b43362",
      measurementId: "G-P03TCWX8SB");
}
