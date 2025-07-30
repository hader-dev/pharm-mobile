import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/widgets/image_load_error_widget.dart';

class PromotionItemWidget extends StatelessWidget {
  final String promotionUrl;
  const PromotionItemWidget({super.key, required this.promotionUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: promotionUrl,
      fit: BoxFit.cover,
      errorWidget: (BuildContext context, String url, Object error) => const ImageLoadErrorWidget(),
    );
  }
}
