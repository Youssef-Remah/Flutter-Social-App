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
    apiKey: 'AIzaSyDc8wcWp4NDAfawaY7dl5_sT670wL3Jx-Y',
    appId: '1:638949808350:web:46a2ef803edc80618d8a4f',
    messagingSenderId: '638949808350',
    projectId: 'flutter-social-app-38f0e',
    authDomain: 'flutter-social-app-38f0e.firebaseapp.com',
    storageBucket: 'flutter-social-app-38f0e.appspot.com',
    measurementId: 'G-43ZS737ZE9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoKMjADtQ-pMVbBdF2JPtpHm77IK9M9qI',
    appId: '1:638949808350:android:99a34f044c1337398d8a4f',
    messagingSenderId: '638949808350',
    projectId: 'flutter-social-app-38f0e',
    storageBucket: 'flutter-social-app-38f0e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1IIPQa_cNCaSlzD4LvwYrALXwsnsusLQ',
    appId: '1:638949808350:ios:f06a393c6f77ddfa8d8a4f',
    messagingSenderId: '638949808350',
    projectId: 'flutter-social-app-38f0e',
    storageBucket: 'flutter-social-app-38f0e.appspot.com',
    iosBundleId: 'com.udemy.socialApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1IIPQa_cNCaSlzD4LvwYrALXwsnsusLQ',
    appId: '1:638949808350:ios:d47f48afd6ccf3408d8a4f',
    messagingSenderId: '638949808350',
    projectId: 'flutter-social-app-38f0e',
    storageBucket: 'flutter-social-app-38f0e.appspot.com',
    iosBundleId: 'com.udemy.socialApp.RunnerTests',
  );
}