import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../config/theme/colors_manager.dart';
import '../../utils/constants.dart';
import 'widgets/image_upload_section.dart';
import 'widgets/profile_picture_setup_header_section.dart';

class ProfilePictureSetup extends StatelessWidget {
  const ProfilePictureSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
          child: Column(
            children: [
              ProfilePictureSetupHeaderSection(),
              Gap(AppSizesManager.s32),
              ImageUploadSection(),
            ],
          ),
        ),
      ),
    );
  }
}
