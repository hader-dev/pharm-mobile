import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FeaturedEntity extends StatelessWidget {
  const FeaturedEntity(
      {super.key,
      required this.title,
      required this.imageUrl,
      this.onPress,
      required this.size});

  final String title;
  final String? imageUrl;
  final VoidCallback? onPress;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(AppSizesManager.p8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CacheNetworkImagePlus(
                width: double.infinity,
                boxFit: BoxFit.cover,
                imageUrl: imageUrl ??
                    "https://images.aeonmedia.co/images/afef287f-dd6f-4a6a-b8a6-4f0a09330657/sized-kendal-l4ikccachoc-unsplash.jpg?width=3840&quality=75&format=auto",
              ),
            ),
          ),
          const Gap(AppSizesManager.s4),
          Expanded(
              child: Text(
            title,
            style: context.responsiveTextTheme.current.body3Medium,
          )),
        ],
      ),
    );
  }
}
