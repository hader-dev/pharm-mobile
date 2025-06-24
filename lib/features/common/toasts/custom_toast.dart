import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/toast_helper.dart';

class CustomToastWidget extends StatefulWidget {
  final String title;
  final String? message;
  final ToastType type;
  final VoidCallback? onClose;
  final VoidCallback? onAction;
  final String? actionText;
  final Duration animationDuration;

  const CustomToastWidget({
    super.key,
    required this.title,
    this.message,
    this.type = ToastType.success,
    this.onClose,
    this.onAction,
    this.actionText,
    this.animationDuration = const Duration(seconds: 3),
  });

  @override
  State<CustomToastWidget> createState() => _CustomToastWidgetState();
}

class _CustomToastWidgetState extends State<CustomToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInCubic);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() async {
      if (_controller.isForwardOrCompleted) {
        await Future.delayed(Duration(seconds: 2, milliseconds: 600));
        _controller.reverse();
      }
      if (_controller.isDismissed) {
        _controller.removeListener(
          () {},
        );
        await Future.delayed(widget.animationDuration);
        widget.onClose?.call();
      }
    });
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return AnimatedOpacity(
              duration: _controller.duration!,
              opacity: _fade.value,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: AppSizesManager.p8),
                  padding: const EdgeInsets.all(AppSizesManager.p16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: widget.type.colors, begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(AppSizesManager.r12),
                  ),
                  child: Row(
                    children: [
                      Icon(widget.type.icon, color: Colors.white),
                      const SizedBox(width: AppSizesManager.s12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                            if (widget.message != null)
                              Text(widget.message!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  )),
                          ],
                        ),
                      ),
                      if (widget.actionText != null)
                        TextButton(
                          onPressed: widget.onAction,
                          style: TextButton.styleFrom(foregroundColor: Colors.white),
                          child: Text(widget.actionText!),
                        ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: widget.onClose ?? () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
