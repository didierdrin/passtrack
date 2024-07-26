import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyDVibO-mEIqqDGCHqo2mtnriUr1YsbDkeA",
    authDomain: "passtrack-3e434.firebaseapp.com",
    projectId: "passtrack-3e434",
    storageBucket: "passtrack-3e434.appspot.com",
    messagingSenderId: "491220286264",
    appId: "1:491220286264:web:9cf12a88695c49f72e9fcd",
    measurementId: "G-GY5N76LQCH", // This is not provided in the JSON, you may need to add it manually
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVibO-mEIqqDGCHqo2mtnriUr1YsbDkeA',
    appId: '1:491220286264:android:9cf12a88695c49f72e9fcd',
    messagingSenderId: '491220286264',
    projectId: 'passtrack-3e434',
    storageBucket: 'passtrack-3e434.appspot.com',
  );
}