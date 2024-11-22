import 'dart:math';

class NanoIdGenerator {
  static final Random _random = Random();
  static const String _alphabet =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  static String generate({int length = 21}) {
    return List<String>.generate(
        length, (_) => _alphabet[_random.nextInt(_alphabet.length)]).join();
  }
}
