import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/assets_strings.dart';
import '../../../utils/constants.dart';
import '../../common/buttons/solid/primary_text_button.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizesManager.p16),
          child: SvgPicture.asset(DrawableAssetStrings.congratsIllustrationImg,
              height: MediaQuery.sizeOf(context).height * 0.3, width: MediaQuery.sizeOf(context).height * 0.3),
        ),
        Padding(
          padding:
              const EdgeInsets.only(right: AppSizesManager.p8, left: AppSizesManager.p8, bottom: AppSizesManager.s16),
          child: Text(
            'Create or join a company (pharmacies, distributors, ...) and explore our marketplace and many more Features.',
            textAlign: TextAlign.center,
            style: AppTypography.body3RegularStyle.copyWith(color: TextColors.ternary.color),
          ),
        ),
        PrimaryTextButton(
          label: "Create a company profile",
          onTap: () {
            GoRouter.of(context).pushReplacementNamed(RoutingManager.createCompanyProfile);
          },
          color: AppColors.accent1Shade1,
        ),
        Gap(AppSizesManager.s12),
        PrimaryTextButton(
          label: "Already a member of a company",
          onTap: () {},
          labelColor: AppColors.accent1Shade1,
        ),
      ],
    );
  }
}
