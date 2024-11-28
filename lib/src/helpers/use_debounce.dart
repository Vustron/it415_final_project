import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'dart:async';

T useDebounce<T>(T value, Duration delay) {
  final ValueNotifier<T> debouncedValue = useState(value);

  useEffect(() {
    final Timer timer = Timer(delay, () {
      debouncedValue.value = value;
    });

    return () => timer.cancel();
  }, <Object?>[value, delay]);

  return debouncedValue.value;
}
