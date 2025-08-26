import 'package:flutter/material.dart';

class ThemeForwarder extends StatelessWidget {
  final Widget child;
  final ThemeData outerTheme;

  const ThemeForwarder({
    super.key,
    required this.child,
    required this.outerTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: outerTheme,
      child: child,
    );
  }
}
