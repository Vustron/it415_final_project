import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/views.dart';

class ErrorView extends HookConsumerWidget {
  const ErrorView({
    super.key,
    required this.error,
    this.stackTrace,
  });

  final String error;
  final StackTrace? stackTrace;

  String _formatStackTrace() {
    if (stackTrace == null) {
      return '';
    }
    final Trace trace = Trace.from(stackTrace!);
    return trace.terse.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoggerService logger = ref.watch(loggerService);

    useEffect(() {
      logger.error('Error occurred', error, stackTrace);

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
      ));

      return null;
    }, const <Object?>[]);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 64.0,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Oops! Something went wrong',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.red,
                      ),
                ),
                if (kDebugMode && stackTrace != null) ...<Widget>[
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      _formatStackTrace(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                            color: Colors.grey[800],
                          ),
                    ),
                  ),
                ],
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    logger.info('Attempting to navigate back to login');
                    CustomRouter.navigateToWithTransition(
                      LoginView(),
                      'rightToLeftWithFade',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalStyles.primaryButtonColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Try Again',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
