import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

class ToastUtils {
  static void showToast({
    required BuildContext context,
    required String title,
    required String message,
    ToastificationType type = ToastificationType.success,
    Duration duration = const Duration(seconds: 3),
    AlignmentGeometry alignment = const Alignment(0, -0.95),
  }) {
    toastification.dismissAll();

    final Map<ToastificationType, Color> typeColors =
        <ToastificationType, Color>{
      ToastificationType.success: Colors.green,
      ToastificationType.error: Colors.red,
      ToastificationType.warning: Colors.orange,
      ToastificationType.info: Colors.blue,
    };

    toastification.show(
      context: context,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      description: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      type: type,
      style: ToastificationStyle.minimal,
      autoCloseDuration: duration,
      alignment: alignment,
      primaryColor: typeColors[type] ?? Colors.blue,
      borderRadius: BorderRadius.circular(12),
      icon: Icon(_getIcon(type)),
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      dragToClose: true,
    );
  }

  static IconData _getIcon(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return Icons.check_circle_outline;
      case ToastificationType.error:
        return Icons.error_outline;
      case ToastificationType.warning:
        return Icons.warning_amber;
      case ToastificationType.info:
        return Icons.info_outline;
      default:
        return Icons.notifications_none;
    }
  }
}
