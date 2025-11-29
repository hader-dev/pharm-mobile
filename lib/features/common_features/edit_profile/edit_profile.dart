import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import 'widgets/form_section.dart';
import 'widgets/profile_image_section.dart' show ProfileImageSection;

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(userManager: getItInstance.get<UserManager>())..initProfileData(),
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        appBar: CustomAppBarV2.normal(
          leading: IconButton(
            icon: Icon(
              Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
              color: AppColors.accent1Shade1,
              size: context.responsiveAppSizeTheme.current.iconSize25,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          title: Text(
            context.translation!.update_profile,
            style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(color: AppColors.accent1Shade1),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p16),
            child: BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) {
                if (state is EditProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const ResponsiveGap.s16(),
                    Text(context.translation!.update_profile_description,
                        style: context.responsiveTextTheme.current.body1Medium.copyWith(
                          color: TextColors.ternary.color,
                        )),
                    const ResponsiveGap.s24(),
                    ProfileImageSection(),
                    const ResponsiveGap.s24(),
                    FormSection(),
                    const ResponsiveGap.s16(),
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
