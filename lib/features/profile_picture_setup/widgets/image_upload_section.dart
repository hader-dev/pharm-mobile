import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../utils/assets_strings.dart';
import '../../../utils/constants.dart';
import '../../common/buttons/solid/primary_icon_button.dart';
import '../../common/buttons/solid/primary_text_button.dart';

class ImageUploadSection extends StatelessWidget {
  const ImageUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizesManager.p24),
          child: Stack(
            children: [
              SvgPicture.asset(DrawableAssetStrings.defaultProfileImgIcon,
                  height: MediaQuery.sizeOf(context).height * 0.3, width: MediaQuery.sizeOf(context).height * 0.3),
              Positioned(
                bottom: AppSizesManager.s16,
                right: AppSizesManager.s16,
                child: PrimaryIconButton(
                  icon: Icon(
                    Iconsax.camera,
                    color: AppColors.bgWhite,
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
        PrimaryTextButton(
          label: "Continue",
          onTap: () {},
          color: AppColors.accent1Shade1,
        ),
        Gap(AppSizesManager.s12),
        PrimaryTextButton(
          label: "Ignore",
          onTap: () {},
          labelColor: AppColors.accent1Shade1,
        ),
      ],
    );
  }
}
