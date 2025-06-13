import 'package:flutter/material.dart';
import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/app_bars/custom_app_bar.dart';

class ProductPhotoSection extends StatelessWidget {
  const ProductPhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CacheNetworkImagePlus(
          height: 320,
          width: double.maxFinite,
          boxFit: BoxFit.fill,
          imageUrl: "https://pharmacie-denni.dz/wp-content/uploads/2025/05/12-2-1.png",
        ),
        CustomAppBar(
            bgColor: Colors.transparent,
            topPadding: MediaQuery.of(context).padding.top,
            bottomPadding: MediaQuery.of(context).padding.bottom,
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_left_2),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
            trailing: [
              IconButton(
                icon: const Icon(Iconsax.heart),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Iconsax.share),
                onPressed: () {},
              ),
            ],
            title: SizedBox.shrink()),
      ],
    );
  }
}
