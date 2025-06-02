import 'package:flutter/material.dart';

class SolidFAB extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final double size;

  const SolidFAB({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color = const Color(0xFF1DA1F2),
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
            color: color,
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
