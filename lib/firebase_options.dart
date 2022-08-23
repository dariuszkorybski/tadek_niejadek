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
    apiKey: 'AIzaSyDPXQwaIudzOvr1dg-fbliEjhAaduWJUls',
    appId: '1:231970697447:web:3dc5b809eb177fcba47242',
    messagingSenderId: '231970697447',
    projectId: 'nakarm-bobasa',
    authDomain: 'nakarm-bobasa.firebaseapp.com',
    storageBucket: 'nakarm-bobasa.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_Fn0uju4Q-2_q-NOndKoYlXbXi_Xk-Q8',
    appId: '1:231970697447:android:6900f5759365fc36a47242',
    messagingSenderId: '231970697447',
    projectId: 'nakarm-bobasa',
    storageBucket: 'nakarm-bobasa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_9XUE-6-fcUXCFPhEE3cSfPRWNitpYBQ',
    appId: '1:231970697447:ios:6c22f9eab965ad83a47242',
    messagingSenderId: '231970697447',
    projectId: 'nakarm-bobasa',
    storageBucket: 'nakarm-bobasa.appspot.com',
    iosClientId:
        '231970697447-ssos11t52h2mpqltfcv643d3o7o21jdg.apps.googleusercontent.com',
    iosBundleId: 'com.dariuszkorybski.tadekNiejadek',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_9XUE-6-fcUXCFPhEE3cSfPRWNitpYBQ',
    appId: '1:231970697447:ios:6c22f9eab965ad83a47242',
    messagingSenderId: '231970697447',
    projectId: 'nakarm-bobasa',
    storageBucket: 'nakarm-bobasa.appspot.com',
    iosClientId:
        '231970697447-ssos11t52h2mpqltfcv643d3o7o21jdg.apps.googleusercontent.com',
    iosBundleId: 'com.dariuszkorybski.tadekNiejadek',
  );
}