// utils
import 'package:babysitterapp/configs/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// configs
import 'configs/root_theme.dart';

// screens
import 'package:babysitterapp/screens/splash.dart';

void main() async {
  // consume dotenv
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();

  // Enter full-screen for initializing splashscreen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // for setting orientations to portrait only
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

// TODO(Vustron): Replace placeholder title with the real title of the app.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BabyCare',
      themeMode: ThemeMode.light,
      theme: rootThemeData(),
      home: const SplashScreen(),
    );
  }
}
