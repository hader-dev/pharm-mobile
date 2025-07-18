import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/register/cubit/register_cubit.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart' show AppTypography;
import '../../../utils/constants.dart';
import '../../common/app_bars/custom_app_bar.dart' show CustomAppBar;
import 'widgets/form_section.dart';
import 'widgets/profile_image_section.dart' show ProfileImageSection;

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(userManager: getItInstance.get<UserManager>())..initProfileData(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.bgWhite,
          appBar: CustomAppBar(
            bgColor: AppColors.bgWhite,
            topPadding: MediaQuery.of(context).padding.top,
            bottomPadding: MediaQuery.of(context).padding.bottom,
            leading: IconButton(
              icon: const Icon(
                Iconsax.arrow_left_2,
                size: AppSizesManager.iconSize25,
              ),
              onPressed: () {
                context.pop();
              },
            ),
            title: const Text(
              "Update Profile",
              style: AppTypography.headLine3SemiBoldStyle,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
            child: BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) {
                if (state is EditProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Text("Update your profile details and upload your profile picture.",
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
