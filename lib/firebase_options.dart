import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError('Platform not supported.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: 'YOUR_WEB_API_KEY',
      appId: 'YOUR_WEB_APP_ID',
      messagingSenderId: '1070542599755',
      projectId: 'greentrack-4bcab',
      storageBucket: 'greentrack-4bcab.firebasestorage.app',
      authDomain: 'greentrack-4bcab.firebaseapp.com');

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyAiGybFAV4lUozMmFSj3BCo1WDLyKuuoUc',
      appId: '1:1070542599755:android:2a3ad399f72d847bea7fce',
      messagingSenderId: '1070542599755',
      projectId: 'greentrack-4bcab',
      storageBucket: 'greentrack-4bcab.firebasestorage.app');

  static const FirebaseOptions ios = FirebaseOptions(
      apiKey: 'YOUR_IOS_API_KEY',
      appId: 'YOUR_IOS_APP_ID',
      messagingSenderId: '1070542599755',
      projectId: 'greentrack-4bcab',
      storageBucket: 'greentrack-4bcab.firebasestorage.app',
      iosClientId: 'YOUR_IOS_CLIENT_ID',
      iosBundleId: 'com.greentrack.greentrack');
}