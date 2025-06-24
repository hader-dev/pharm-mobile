import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../utils/constants.dart';
import '../../common/app_bars/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          bgColor: AppColors.bgWhite,
          topPadding: MediaQuery.of(context).padding.top,
          bottomPadding: MediaQuery.of(context).padding.bottom,
          leading: IconButton(
            icon: const Icon(
              Iconsax.home,
              size: AppSizesManager.iconSize25,
            ),
            onPressed: () {},
          ),
          title: const Text(
            "Home",
            style: AppTypography.headLine3SemiBoldStyle,
          ),
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
        body: const Placeholder());
  }
}
