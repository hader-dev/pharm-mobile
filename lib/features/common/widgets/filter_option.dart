import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/theme/colors_manager.dart';

class FilterOptionWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const FilterOptionWidget(
      {super.key, this.title = 'Default', this.subTitle = 'Default'});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              title,
              style: context.responsiveTextTheme.current.body3Medium,
            ),
            Text(
              subTitle,
              style: context.responsiveTextTheme.current.bodySmall
                  .copyWith(color: TextColors.ternary.color),
            ),
          ],
        ),
        Spacer(),
        PrimaryIconButton(
          icon: Icon(
            Iconsax.arrow_right_3,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
