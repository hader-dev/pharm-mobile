import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/assets_strings.dart';
import '../../../common/buttons/solid/primary_text_button.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.responsiveAppSizeTheme.current.p16),
          child: SvgPicture.asset(DrawableAssetStrings.congratsIllustrationImg,
              height: MediaQuery.sizeOf(context).height * 0.3,
              width: MediaQuery.sizeOf(context).height * 0.3),
        ),
        Padding(
          padding: EdgeInsets.only(
              right: context.responsiveAppSizeTheme.current.p8,
              left: context.responsiveAppSizeTheme.current.p8,
              bottom: context.responsiveAppSizeTheme.current.s16),
          child: Text(
            context.translation!.create_company_description,
            textAlign: TextAlign.center,
            style: context.responsiveTextTheme.current.body3Regular
                .copyWith(color: TextColors.ternary.color),
          ),
        ),
        PrimaryTextButton(
          label: context.translation!.create_company_profile_btn,
          onTap: () {
            GoRouter.of(context)
                .pushReplacementNamed(RoutingManager.createCompanyProfile);
          },
          color: AppColors.accent1Shade1,
        ),
        const ResponsiveGap.s12(),
        PrimaryTextButton(
          label: context.translation!.already_member_btn,
          onTap: () {
            GoRouter.of(context)
                .pushReplacementNamed(RoutingManager.loginScreen);
          },
          labelColor: AppColors.accent1Shade1,
        ),
      ],
    );
  }
}
