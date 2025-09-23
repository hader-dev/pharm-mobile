import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../config/theme/colors_manager.dart';
import '../app_layout/widgets/app_nav_bar/app_nav_bar.dart';
import '../common/app_bars/custom_app_bar.dart';
import '../common/buttons/outlined/outlined_filled_text_button.dart';
import '../common/floating_buttons/custom_solid_fab.dart';

class AppComponentsScreen extends StatefulWidget {
  const AppComponentsScreen({super.key, required this.title});

  final String title;

  @override
  State<AppComponentsScreen> createState() => _AppComponanatsPageState();
}

class _AppComponanatsPageState extends State<AppComponentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: AppNavBar(),
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
            trailing: [
              IconButton(
                icon: const Icon(Iconsax.search_normal),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Iconsax.notification),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Iconsax.notification),
                onPressed: () {},
              ),
            ],
            title: Text(
              widget.title,
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
        floatingActionButton: SolidFAB(
          icon: Icons.add,
          color: AppColors.accent1Shade1,
          onPressed: () {},
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            OutLinedFilledTextButton(),
          ]),
        ));
  }
}
