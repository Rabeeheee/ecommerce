// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC0c66F2eNcM7T1PVBRdRuf4bOLSkeCD2I',
    appId: '1:560391679422:web:229e21ee191f0f9e93ddef',
    messagingSenderId: '560391679422',
    projectId: 'tech-heaven-7d347',
    authDomain: 'tech-heaven-7d347.firebaseapp.com',
    storageBucket: 'tech-heaven-7d347.firebasestorage.app',
    measurementId: 'G-TV6LMYW5WK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOGp0TeCCl2dcYvNHwg0sxY9xJZbtQaC8',
    appId: '1:560391679422:android:f18ffc63839780c193ddef',
    messagingSenderId: '560391679422',
    projectId: 'tech-heaven-7d347',
    storageBucket: 'tech-heaven-7d347.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAiWVnpANUE3m11tiIZ1mBgKGdmLENV9HA',
    appId: '1:560391679422:ios:45efc52b355521e293ddef',
    messagingSenderId: '560391679422',
    projectId: 'tech-heaven-7d347',
    storageBucket: 'tech-heaven-7d347.firebasestorage.app',
    androidClientId: '560391679422-vman8m9abm0vrks83c9cok2h985pgu5r.apps.googleusercontent.com',
    iosClientId: '560391679422-5ljaahokp9pnakuk796b0f8c0sheh5g1.apps.googleusercontent.com',
    iosBundleId: 'com.example.techHeaven',
  );
}
