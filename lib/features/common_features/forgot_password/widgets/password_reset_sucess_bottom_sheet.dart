import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class PasswordResetSuccessSentScreen extends StatelessWidget {
  const PasswordResetSuccessSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.chart_success,
            size: 150,
            color: AppColors.accent1Shade1,
            opticalSize: 30,
          ),
          const ResponsiveGap.s24(),
          Text(context.translation!.password_reset_success,
              style: context.responsiveTextTheme.current.headLine2),
          const ResponsiveGap.s24(),
          PrimaryTextButton(
              label: context.translation!.back_to_login,
              onTap: () {
                context.pop();
              },
              color: AppColors.accent1Shade1),
        ],
      ),
    );
  }
}
