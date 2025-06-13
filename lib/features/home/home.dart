import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../config/theme/colors_manager.dart';
import '../common/app_bars/custom_app_bar.dart';

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
            icon: const Icon(Iconsax.arrow_left_2),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Home"),
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
