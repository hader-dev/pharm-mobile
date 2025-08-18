import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart' show AppTypography;
import '../../../utils/constants.dart';
import 'widgets/form_section.dart';
import 'widgets/profile_image_section.dart' show ProfileImageSection;

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditProfileCubit(userManager: getItInstance.get<UserManager>())
            ..initProfileData(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.bgWhite,
          appBar: CustomAppBarV2.alternate(
            leading: IconButton(
              icon: Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Iconsax.arrow_right_3
                    : Iconsax.arrow_left_2,
                color: AppColors.bgWhite,
                size: AppSizesManager.iconSize25,
              ),
              onPressed: () {
                context.pop();
              },
            ),
            title: Text(
              context.translation!.update_profile,
              style: AppTypography.headLine3SemiBoldStyle
                  .copyWith(color: AppColors.bgWhite),
            ),
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
            child: BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) {
                if (state is EditProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Text(context.translation!.update_profile_description,
                        style: AppTypography.body1MediumStyle.copyWith(
                          color: TextColors.ternary.color,
                        )),
                    Gap(AppSizesManager.s24),
                    ProfileImageSection(),
                    Gap(AppSizesManager.s24),
                    FormSection(),
                    Gap(AppSizesManager.s16),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
