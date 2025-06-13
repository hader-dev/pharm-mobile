import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

import '../../config/theme/colors_manager.dart';
import '../common/app_bars/custom_app_bar.dart';
import 'widgets/tabs_section.dart';

class MarketPlaceScreen extends StatelessWidget {
  const MarketPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          bgColor: AppColors.bgWhite,
          topPadding: MediaQuery.of(context).padding.top,
          bottomPadding: MediaQuery.of(context).padding.bottom,
          leading: IconButton(
            icon: const Icon(
              Iconsax.shop,
              size: AppSizesManager.iconSize25,
            ),
            onPressed: () {},
          ),
          title: const Text("Market Place"),
          trailing: [
            IconButton(
              icon: const Icon(Iconsax.search_normal),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Iconsax.notification),
              onPressed: () {},
            ),
          ],
        ),
        body: MarketPlaceTabBarSection());
  }
}
