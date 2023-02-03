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
    apiKey: 'AIzaSyBHfyK0X_O7oO0SDkIUp8ekIk-u1ScV0Rc',
    appId: '1:811306280345:web:9219a2a7a775c14635df08',
    messagingSenderId: '811306280345',
    projectId: 'appointment-schedule-c0f52',
    authDomain: 'appointment-schedule-c0f52.firebaseapp.com',
    storageBucket: 'appointment-schedule-c0f52.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHfyK0X_O7oO0SDkIUp8ekIk-u1ScV0Rc',
    appId: '1:811306280345:android:fc689e99dbbdcce335df08',
    messagingSenderId: '811306280345',
    projectId: 'appointment-schedule-c0f52',
    storageBucket: 'appointment-schedule-c0f52.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtp9wG-RlP3b197heO1CvO_C6rcyNrv8E',
    appId: '1:811306280345:ios:558467cd01c94e1e35df08',
    messagingSenderId: '811306280345',
    projectId: 'appointment-schedule-c0f52',
    storageBucket: 'appointment-schedule-c0f52.appspot.com',
    iosClientId:
        '811306280345-p9sonufrios5683j8ej8rtupitqbj066.apps.googleusercontent.com',
    iosBundleId: 'com.example.appointmentScheduleApp',
  );
}