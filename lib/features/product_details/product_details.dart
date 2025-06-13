import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../config/theme/colors_manager.dart';
import '../../utils/constants.dart';
import 'sub_pages/details/details.dart';
import 'sub_pages/order_overview/order_overview.dart';
import 'widgets/buttons_section.dart';
import 'widgets/header_section.dart';
import 'widgets/other_products.dart';
import 'widgets/product_photo_section.dart';
import 'widgets/tap_bar_section.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                ProductPhotoSection(),
                HeaderSection(),
                Gap(AppSizesManager.s24),
                ProductDetailsTabBarSection(),
                IndexedStack(
                  index: 1,
                  children: [
                    OrderOverviewPage(),
                    DetailsPage(),
                  ],
                ),
                Divider(color: AppColors.bgDisabled, thickness: 3.5, height: 1),
                OtherProductsSection(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizesManager.p12),
            child: ButtonsSection(),
          ),
        ],
      )),
    );
  }
}
