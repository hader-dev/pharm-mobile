import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/cupertino.dart';

class CachedNetworkImageWithAssetFallback extends StatelessWidget {
  final String imageUrl;
  final String assetImage;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const CachedNetworkImageWithAssetFallback({
    super.key,
    required this.imageUrl,
    required this.assetImage,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CacheNetworkImagePlus(
        imageUrl: imageUrl,
        width: width,
        height: height,
        boxFit: fit ?? BoxFit.fill,
        errorWidget: Image.asset(
          assetImage,
          height: height,
          width: width,
          fit: fit,
        ));
  }
}
