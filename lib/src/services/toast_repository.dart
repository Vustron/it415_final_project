import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

enum ToastType { success, error, warning, info }

class ToastRepository {
  ToastificationType _getToastificationType(String type) {
    switch (type.toLowerCase()) {
      case 'success':
        return ToastificationType.success;
      case 'error':
        return ToastificationType.error;
      case 'warning':
        return ToastificationType.warning;
      case 'info':
        return ToastificationType.info;
      default:
        return ToastificationType.success;
    }
  }

  void show({
    required BuildContext context,
    required String title,
    required String message,
    String type = 'success',
  }) {
    final ToastificationType toastType = _getToastificationType(type);

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
      type: toastType,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: const Alignment(0, -0.95),
      primaryColor: typeColors[toastType] ?? Colors.blue,
      borderRadius: BorderRadius.circular(12),
      icon: Icon(_getIcon(toastType)),
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      dragToClose: true,
    );
  }

  IconData _getIcon(ToastificationType type) {
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
