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
    apiKey: 'AIzaSyDjI2h1xZ5RZUAPZ8tbHKq_no-STMEfcLw',
    appId: '1:854017356972:web:3cf3c76294d14a91249b09',
    messagingSenderId: '854017356972',
    projectId: 'fsociety-878ed',
    authDomain: 'fsociety-878ed.firebaseapp.com',
    storageBucket: 'fsociety-878ed.appspot.com',
    measurementId: 'G-1NYZ0ED8HH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyByWhcZGoyb4J5wsLVbmcrOoxBp_Au95EU',
    appId: '1:854017356972:android:fd3674b03c1d0926249b09',
    messagingSenderId: '854017356972',
    projectId: 'fsociety-878ed',
    storageBucket: 'fsociety-878ed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgT-tkWNjybS8Btp1t4qCUHATs4guU2ko',
    appId: '1:854017356972:ios:069ff8f5549862d5249b09',
    messagingSenderId: '854017356972',
    projectId: 'fsociety-878ed',
    storageBucket: 'fsociety-878ed.appspot.com',
    iosClientId: '854017356972-6f5poseinf524kpno5hdjhk87oprcpfm.apps.googleusercontent.com',
    iosBundleId: 'com.example.fsociety',
  );
}
