import 'package:flutter/material.dart';

import '../config/routes/routing_manager.dart';
import '../features/common/toasts/custom_toast.dart';

enum ToastType {
  success(colors: [Color.fromARGB(255, 102, 187, 106), Color.fromARGB(255, 67, 160, 71)], icon: Icons.check_circle),
  info(colors: [Color.fromARGB(255, 66, 165, 245), Color.fromARGB(255, 30, 136, 229)], icon: Icons.info),
  warning(colors: [Color.fromARGB(255, 255, 167, 38), Color.fromARGB(255, 251, 140, 0)], icon: Icons.warning),
  error(colors: [Color.fromARGB(255, 239, 83, 80), Color.fromARGB(255, 229, 57, 53)], icon: Icons.error),
  ;

  final List<Color> colors;
  final IconData icon;
  const ToastType({
    required this.colors,
    required this.icon,
  });
}

class ToastManager {
  static final ToastManager _instance = ToastManager._internal();
  factory ToastManager() => _instance;
  ToastManager._internal();

  OverlayEntry? _overlayEntry;

  void showToast({
    required ToastType type,
    String? message,
    Duration duration = const Duration(milliseconds: 150),
  }) async {
    Future<void> hideToast() async {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }

    if (_overlayEntry != null) {
      await hideToast();
    }
    _overlayEntry = OverlayEntry(
      maintainState: true,
      builder: (_) => CustomToastWidget(
          title: type.name,
          message: message ?? 'Custom toast via OverlayEntry!',
          type: type,
          animationDuration: duration,
          onClose: () {
            hideToast();
          }),
    );

    Overlay.of(RoutingManager.rootNavigatorKey.currentContext!).insert(_overlayEntry!);
  }
}
