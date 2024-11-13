import 'package:babysitterapp/models/user_account.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controllers/auth_controller.dart';

import 'core/constants.dart';
import 'core/config.dart';
import 'core/state.dart';

import 'views/splash.dart';
import 'views/home.dart';
import 'views/auth.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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

    runApp(ProviderScope(child: App()));
  });
}

class App extends ConsumerWidget with GlobalStyles {
  App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthenticationState>(authController,
        (AuthenticationState? previous, AuthenticationState next) {
      if (next.maybeWhen(authenticated: (_) => true, orElse: () => false)) {
        navigatorKey.currentState?.pushAndRemoveUntil(
          PageTransition<void>(
            type: PageTransitionType.rightToLeftWithFade,
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 300),
            child: HomeView(),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        navigatorKey.currentState?.pushAndRemoveUntil(
          PageTransition<void>(
            type: PageTransitionType.rightToLeftWithFade,
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 300),
            child: const LoginView(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    });

    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'BabyCare',
            themeMode: ThemeMode.light,
            theme: rootThemeData(),
            home: const SplashView(),
            builder: (BuildContext context, Widget? widget) {
              final Widget mediaQueryWidget = MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );

              return Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final AuthenticationState authState =
                      ref.watch(authController);

                  return authState.maybeWhen(
                    loading: () {
                      print('Loading...');
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(
                            color: GlobalStyles.primaryButtonColor,
                          ),
                        ),
                      );
                    },
                    orElse: () => mediaQueryWidget,
                  );
                },
                child: mediaQueryWidget,
              );
            },
          );
        },
      ),
    );
  }
}
