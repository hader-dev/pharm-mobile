import 'package:flutter/material.dart';

class BlackenedBackground extends StatelessWidget {
  const BlackenedBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.black26,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.black26,
            ],
          ),
        ),
        child: null);
  }
}
