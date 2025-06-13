import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants.dart';
import '../../common/buttons/solid/primary_text_button.dart';
import 'make_order_bottom_sheet.dart';

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
      child: Row(
        children: [
          Expanded(
            child: PrimaryTextButton(
              isOutLined: true,
              label: "Add to cart",
              leadingIcon: Iconsax.add,
              labelColor: AppColors.accent1Shade1,
              onTap: () {},
              borderColor: AppColors.accent1Shade1,
            ),
          ),
          Gap(AppSizesManager.s8),
          Expanded(
            child: PrimaryTextButton(
              label: "Buy now",
              leadingIcon: Iconsax.money4,
              onTap: () {
                BottomSheetHelper.showCommonBottomSheet(context: context, child: MakeOrderBottomSheet());
              },
              color: AppColors.accent1Shade1,
            ),
          ),
        ],
      ),
    );
  }
}
