import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/check_email/cubit/check_email_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class CheckEmailHeaderSection extends StatelessWidget {
  const CheckEmailHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.read<CheckEmailCubit>().state;
    final translation = context.translation!;
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          const ResponsiveGap.s24(),
          Text(
            translation.verify_email,
            style: context.responsiveTextTheme.current.headLine1.copyWith(
                fontSize: AppSizesManager.p24, color: AppColors.accent1Shade1),
          ),
          const ResponsiveGap.s8(),
          Text(
            translation.hint_please_enter_otp_sent_to_email,
            style: context.responsiveTextTheme.current.body3Regular
                .copyWith(color: TextColors.ternary.color),
          ),
          const ResponsiveGap.s4(),
          Text(
            state.userEmail,
            style: context.responsiveTextTheme.current.body3Medium
                .copyWith(color: TextColors.primary.color),
          ),
        ],
      ),
    );
  }
}
