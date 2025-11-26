import 'package:flutter/material.dart' show Colors;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart' show Container, Widget;
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerHelper {
  static Widget generateShimmer({double? width, double? height, double radius = 0, isCircular = false}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircular ? null : BorderRadius.circular(radius),
      ),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        interval: const Duration(seconds: 2),
        color: Colors.grey.shade800,
        colorOpacity: 0.2,
        enabled: true,
        direction: const ShimmerDirection.fromLTRB(),
        child: Container(),
      ),
    );
  }
}
