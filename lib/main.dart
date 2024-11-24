import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/config.dart';
import 'package:babysitterapp/src/views.dart';

void main() {
  Chain.capture(() async {
    final ProviderContainer container = ProviderContainer();
    final LoggerService logger = container.read(loggerService);

    try {
      logger.info('Initializing app...');
      WidgetsFlutterBinding.ensureInitialized();

      logger.debug('Configuring system UI...');
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      logger.debug('Loading environment variables...');
      await dotenv.load();

      logger.debug('Initializing Firebase...');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FlutterError.onError = (FlutterErrorDetails details) {
        logger.error(
          'Flutter error caught',
          details.exception,
          details.stack,
        );
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

      logger.info('Starting app...');
      runApp(ProviderScope(child: App()));
    } catch (e, stackTrace) {
      logger.error('Failed to initialize app', e, stackTrace);
      rethrow;
    }
  }, onError: (Object error, Chain stackTrace) {
    final ProviderContainer container = ProviderContainer();
    final LoggerService logger = container.read(loggerService);

    logger.error(
      'Uncaught error',
      error,
      stackTrace,
    );

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
