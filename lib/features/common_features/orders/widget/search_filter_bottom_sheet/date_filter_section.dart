import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';

import '../../../../../config/theme/colors_manager.dart' show AppColors;
import '../../../../../config/theme/typoghrapy_manager.dart' show AppTypography;
import '../../../../../utils/constants.dart';

import '../../../para_pharma_catalog_details/widgets/make_order_bottom_sheet.dart' show InfoWidget;

import 'price_tag.dart' show PriceTag;

class DateFilterSection extends StatelessWidget {
  const DateFilterSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      label: "Date : ",
      bgColor: AppColors.bgWhite,
      value: Padding(
        padding: const EdgeInsets.only(top: AppSizesManager.p16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Initial date",
                  style: AppTypography.body2MediumStyle,
                ),
                const Gap(AppSizesManager.s8),
                Text(
                  "21/12/2025",
                  style: AppTypography.body2MediumStyle.copyWith(color: AppColors.accent1Shade1),
                ),
              ],
            ),
            Icon(
              Icons.arrow_right_alt,
              color: Colors.grey,
              size: AppSizesManager.iconSize25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Final date",
                  style: AppTypography.body2MediumStyle,
                ),
                const Gap(AppSizesManager.s8),
                Text(
                  "21/12/2025",
                  style: AppTypography.body2MediumStyle.copyWith(color: AppColors.accent1Shade1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
