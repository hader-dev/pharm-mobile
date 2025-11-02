import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditProfileCubit>(context);
    final state = cubit.state;
    final userImage = getItInstance.get<UserManager>().currentUser.image;
    final imageUrl = userImage != null
        ? getItInstance.get<INetworkService>().getFilesPath(userImage.path)
        : null;

    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768;
    final imageSize =
        isTablet ? 120.0 : MediaQuery.sizeOf(context).height * 0.2;

    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              cubit.pickUserImage();
            },
            splashColor: Colors.transparent,
            child: Stack(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: context.responsiveAppSizeTheme.current.p4),
                    clipBehavior: Clip.antiAlias,
                    height: imageSize,
                    width: imageSize,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.bgDarken,
                        border: Border.all(color: AppColors.bgDarken2)),
                    child: _buildImageWidget(state, imageUrl)),
                Positioned(
                    bottom: context.responsiveAppSizeTheme.current.s4,
                    right: context.responsiveAppSizeTheme.current.s4 / 2,
                    child: Transform.scale(
                      scale: 0.7,
                      child: PrimaryIconButton(
                        icon: Icon(
                          state.pickedImage != null
                              ? Iconsax.edit_2
                              : Iconsax.add,
                          color: Colors.white,
                        ),
                        isBordered: true,
                        borderColor: Colors.white,
                        onPressed: () {
                          cubit.pickUserImage();
                        },
                      ),
                    )),
                if (state.pickedImage != null)
                  Positioned(
                    top: context.responsiveAppSizeTheme.current.s4,
                    right: context.responsiveAppSizeTheme.current.s4 / 2,
                    child: Transform.scale(
                      scale: 0.7,
                      child: PrimaryIconButton(
                        isBordered: true,
                        borderColor: Colors.white,
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        bgColor: SystemColors.red.primary,
                        onPressed: () {
                          cubit.removeImage();
                        },
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(EditProfileState state, String? imageUrl) {
    if (state.pickedImage != null) {
      return Image.file(
        File(state.pickedImage!.path),
        fit: BoxFit.cover,
      );
    }

    return CachedNetworkImageWithAssetFallback(
      imageUrl: imageUrl ?? "",
      fit: BoxFit.cover,
      assetImage: DrawableAssetStrings.defaultProfileImgIcon,
    );
  }
}
