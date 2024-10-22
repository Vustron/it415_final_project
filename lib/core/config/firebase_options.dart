// third party
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// flutter
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: dotenv.env['WEB_API_KEY'] ?? '',
        appId: dotenv.env['WEB_APP_ID'] ?? '',
        messagingSenderId: dotenv.env['WEB_MESSAGINGSENDER_ID'] ?? '',
        projectId: dotenv.env['WEB_PROJECT_ID'] ?? '',
        authDomain: dotenv.env['WEB_AUTH_DOMAIN'] ?? '',
        storageBucket: dotenv.env['WEB_STORAGEBUCKET'] ?? '',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return FirebaseOptions(
          apiKey: dotenv.env['ANDROID_API_KEY'] ?? '',
          appId: dotenv.env['ANDROID_APP_ID'] ?? '',
          messagingSenderId: dotenv.env['ANDROID_MESSAGINGSENDER_ID'] ?? '',
          projectId: dotenv.env['ANDROID_PROJECT_ID'] ?? '',
          storageBucket: dotenv.env['ANDROID_STORAGEBUCKET'] ?? '',
        );
      case TargetPlatform.iOS:
        return FirebaseOptions(
          apiKey: dotenv.env['IOS_API_KEY'] ?? '',
          appId: dotenv.env['IOS_APP_ID'] ?? '',
          messagingSenderId: dotenv.env['IOS_MESSAGINGSENDER_ID'] ?? '',
          projectId: dotenv.env['IOS_PROJECT_ID'] ?? '',
          storageBucket: dotenv.env['IOS_STORAGEBUCKET'] ?? '',
          iosBundleId: dotenv.env['IOS_BUNDLE_ID'] ?? '',
        );
      case TargetPlatform.macOS:
        return FirebaseOptions(
          apiKey: dotenv.env['MACOS_API_KEY'] ?? '',
          appId: dotenv.env['MACOS_APP_ID'] ?? '',
          messagingSenderId: dotenv.env['MACOS_MESSAGINGSENDER_ID'] ?? '',
          projectId: dotenv.env['MACOS_PROJECT_ID'] ?? '',
          storageBucket: dotenv.env['MACOS_STORAGEBUCKET'] ?? '',
          iosBundleId: dotenv.env['MACOS_BUNDLE_ID'] ?? '',
        );
      case TargetPlatform.windows:
        return FirebaseOptions(
          apiKey: dotenv.env['WINDOWS_API_KEY'] ?? '',
          appId: dotenv.env['WINDOWS_APP_ID'] ?? '',
          messagingSenderId: dotenv.env['WINDOWS_MESSAGINGSENDER_ID'] ?? '',
          projectId: dotenv.env['WINDOWS_PROJECT_ID'] ?? '',
          authDomain: dotenv.env['WINDOWS_AUTH_DOMAIN'] ?? '',
          storageBucket: dotenv.env['WINDOWS_STORAGEBUCKET'] ?? '',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
}
