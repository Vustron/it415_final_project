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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: App()));
}

class App extends ConsumerWidget with GlobalStyles {
  App({super.key});

  void _handleAuthStateChange(BuildContext context, AuthenticationState state) {
    final NavigatorState? navigator = navigatorKey.currentState;
    if (navigator == null) {
      return;
    }

    final Widget targetScreen = state.maybeWhen(
      authenticated: (_) => const BottomNavbarView(),
      orElse: () => const LoginView(),
    );

    navigator.pushAndRemoveUntil(
      PageTransition<void>(
        type: PageTransitionType.rightToLeftWithFade,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        child: targetScreen,
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthenticationState>(
      authController,
      (AuthenticationState? previous, AuthenticationState next) =>
          _handleAuthStateChange(context, next),
    );

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'BabyCare',
        themeMode: ThemeMode.light,
        theme: rootThemeData(),
        home: Consumer(
          builder: (BuildContext context, WidgetRef ref, _) {
            final AuthenticationState authState = ref.watch(authController);

            return authState.maybeWhen(
              authenticated: (_) => const BottomNavbarView(),
              unauthenticated: (String? _) => const LoginView(),
              loading: () => const SplashView(),
              orElse: () => const SplashView(),
            );
          },
        ),
        builder: (BuildContext context, Widget? widget) {
          if (widget == null) {
            return const SizedBox.shrink();
          }

          final MediaQuery mediaQueryWidget = MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget,
          );

          return Consumer(
            builder: (BuildContext context, WidgetRef ref, _) {
              final AuthenticationState authState = ref.watch(authController);

              return authState.maybeWhen(
                loading: () => const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: GlobalStyles.primaryButtonColor,
                    ),
                  ),
                ),
                orElse: () => mediaQueryWidget,
              );
            },
          );
        },
      ),
    );
  }
}
