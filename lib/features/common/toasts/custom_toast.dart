import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';



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

class _CustomToastWidgetState extends State<CustomToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInCubic);
    _controller.forward();
    
    // Add listener in initState, not in build method
    _controller.addListener(_animationListener);
    
    // Add listener in initState, not in build method
    _controller.addListener(_animationListener);
  }

  void _animationListener() async {
    if (_controller.isForwardOrCompleted) {
      await Future.delayed(Duration(seconds: 2, milliseconds: 600));
      // Check if widget is still mounted
      if (mounted) {
        _controller.reverse();
      }
    }
    if (_controller.isDismissed) {
      await Future.delayed(widget.animationDuration);
      if (mounted) {
        widget.onClose?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        colors: widget.type.colors,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(AppSizesManager.r12),
                  ),
                  child: Row(
                    children: [
                      Icon(widget.type.icon, color: Colors.white),
                      const ResponsiveGap.s12(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
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
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
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
    _controller.removeListener(_animationListener);
    _controller.dispose();
    super.dispose();
  }
}
