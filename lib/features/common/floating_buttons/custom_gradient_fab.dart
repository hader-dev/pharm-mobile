import 'package:flutter/material.dart';

class GradientFAB extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final List<Color> gradientColors;
  final double size;

  const GradientFAB({
    super.key,
    required this.icon,
    required this.onPressed,
    this.gradientColors = const [Color(0xFF1DA1F2), Color(0xFF0F8EC9)],
    this.size = 56.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: RawMaterialButton(
        shape: const CircleBorder(),
        elevation: 0,
        fillColor: Colors.transparent,
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: size * 0.45,
            ),
          ),
        ),
      ),
    );
  }
}
