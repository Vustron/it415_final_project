// third-party
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

// flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// core
import 'core/config/firebase_options.dart';
import 'core/config/theme.dart';

// views
import 'views/auth/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enter full-screen for initializing splashscreen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // for setting orientations to portrait only
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    // consume dotenv
    await dotenv.load();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(const App());
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BabyCare',
        themeMode: ThemeMode.light,
        theme: rootThemeData(),
        home: const SplashView(),
      ),
    );
  }
}
