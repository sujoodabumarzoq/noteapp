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
    apiKey: 'AIzaSyDMl7SbGQ09jN-7FOt9gFZp8xN-89Zhsks',
    appId: '1:401712246853:web:2ee1b5f9755de9e1e6332c',
    messagingSenderId: '401712246853',
    projectId: 'note-df5c2',
    authDomain: 'note-df5c2.firebaseapp.com',
    storageBucket: 'note-df5c2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjH4Qvw2iUzEBJwv1wNHILNJOTxPYsQl8',
    appId: '1:401712246853:android:efa9521d09ce1d4ce6332c',
    messagingSenderId: '401712246853',
    projectId: 'note-df5c2',
    storageBucket: 'note-df5c2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBEz9fZp9MwrdjSh_umecnuK8oQUUB8j0',
    appId: '1:401712246853:ios:0575184df8f3cb35e6332c',
    messagingSenderId: '401712246853',
    projectId: 'note-df5c2',
    storageBucket: 'note-df5c2.appspot.com',
    iosBundleId: 'com.example.noteapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDBEz9fZp9MwrdjSh_umecnuK8oQUUB8j0',
    appId: '1:401712246853:ios:7538b23fd728e0efe6332c',
    messagingSenderId: '401712246853',
    projectId: 'note-df5c2',
    storageBucket: 'note-df5c2.appspot.com',
    iosBundleId: 'com.example.noteapp.RunnerTests',
  );
}
