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
    apiKey: 'AIzaSyA_6now5nKVN5SeUk5kLC0suj62zJt68o4',
    appId: '1:549613408038:web:1bbf93e1506af86a7fbbe7',
    messagingSenderId: '549613408038',
    projectId: 'cloudtalk-fe645',
    authDomain: 'cloudtalk-fe645.firebaseapp.com',
    storageBucket: 'cloudtalk-fe645.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqdkbt0is1SUQg0ERc76wRrmdsciIliH0',
    appId: '1:549613408038:android:c0c97ca8444497177fbbe7',
    messagingSenderId: '549613408038',
    projectId: 'cloudtalk-fe645',
    storageBucket: 'cloudtalk-fe645.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9Bgvn0WPWGf5RJL7VvAuhARDlxThcAFM',
    appId: '1:549613408038:ios:a97091a1c5c086d47fbbe7',
    messagingSenderId: '549613408038',
    projectId: 'cloudtalk-fe645',
    storageBucket: 'cloudtalk-fe645.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA9Bgvn0WPWGf5RJL7VvAuhARDlxThcAFM',
    appId: '1:549613408038:ios:0b45d9b417d5b91f7fbbe7',
    messagingSenderId: '549613408038',
    projectId: 'cloudtalk-fe645',
    storageBucket: 'cloudtalk-fe645.appspot.com',
    iosBundleId: 'com.example.chatapp.RunnerTests',
  );
}