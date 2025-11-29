import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:hader_pharm_mobile/features/common/widgets/image_load_error_widget.dart'
    show ImageLoadErrorWidget;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class CachedNetworkImageWithDrawableFallback extends StatelessWidget {
  final String imageUrl;
  final String? errorAssetImagePath;
  final String? errorSvgImgPath;
  final double? errorImgSize;
  final String? errorMsg;
  final TextStyle? errorStyle;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const CachedNetworkImageWithDrawableFallback.withErrorAssetImage({
    super.key,
    required this.imageUrl,
    required this.errorAssetImagePath,
    this.errorImgSize,
    this.errorMsg,
    this.errorStyle,
    this.height,
    this.width,
    this.errorSvgImgPath,
    this.fit,
  });
  const CachedNetworkImageWithDrawableFallback.withErrorSvgImage({
    super.key,
    required this.imageUrl,
    this.errorAssetImagePath,
    this.height,
    this.width,
    this.errorImgSize,
    this.errorMsg,
    this.errorStyle,
    this.errorSvgImgPath,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CacheNetworkImagePlus(
        imageUrl: imageUrl,
        width: width,
        height: height,
        boxFit: fit ?? BoxFit.fill,
        errorWidget: errorAssetImagePath != null
            ? Image.asset(
                errorAssetImagePath!,
                height: height,
                width: width,
                fit: fit,
              )
            : ImageLoadErrorWidget(
                iconSize: errorImgSize ??
                    context.responsiveAppSizeTheme.current.iconSize48,
                errorMsg: errorMsg,
                errorStyle: errorStyle,
                iconPath: errorSvgImgPath,
              ));
  }
}
