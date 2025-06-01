import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/common/toasts/reusable_toast.dart';

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
    required BuildContext context,
    Duration duration = const Duration(seconds: 3),
  }) async {
    // Remove existing toast if visible
    _overlayEntry?.remove();

    _overlayEntry = OverlayEntry(
      maintainState: true,
      builder: (_) => CustomToastWidget(
          title: 'Success',
          message: 'Custom toast via OverlayEntry!',
          type: ToastType.error,
          actionText: "Undo",
          onAction: () => print("Action pressed"),
          onClose: () {
            hideToast();
          }),
    );

    Overlay.of(context).insert(_overlayEntry!);

    await Future.delayed(duration, () async {
      hideToast();
    });
  }

  void hideToast() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
