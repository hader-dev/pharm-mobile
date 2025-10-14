import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../config/theme/colors_manager.dart';

class OtherProductsSection extends StatelessWidget {
  const OtherProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizesManager.p12),
          child: Text(
            'Other Products',
            style: context.responsiveTextTheme.current.headLine3SemiBold
                .copyWith(color: AppColors.accent1Shade1),
          ),
        ),
        // ConstrainedBox(
        //     constraints: BoxConstraints(maxHeight: 400),
        //     child: ListView(
        //       children: List.generate(10, (index) => ParaPharmaWidget2()),
        //     )),
      ],
    );
  }
}
