import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/config.dart';
import 'package:babysitterapp/src/views.dart';

void main() {
  Chain.capture(() async {
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

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      final Trace trace = Trace.from(details.stack ?? StackTrace.current);
      Navigator.of(CustomRouter.navigatorKey.currentContext!).push(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => ErrorView(
            error: details.exception.toString(),
            stackTrace: trace.terse,
          ),
        ),
      );
    };

    runApp(ProviderScope(child: App()));
  }, onError: (Object error, Chain stackTrace) {
    debugPrint('Caught error: $error');
    final Trace trace = Trace.from(stackTrace);
    debugPrint('Stack trace: ${trace.terse}');

    if (CustomRouter.navigatorKey.currentContext != null) {
      Navigator.of(CustomRouter.navigatorKey.currentContext!).push(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => ErrorView(
            error: error.toString(),
            stackTrace: trace.terse,
          ),
        ),
      );
    }
  });
}
