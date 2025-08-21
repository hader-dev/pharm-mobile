import 'dart:io' show File;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:iconsax/iconsax.dart';
import '../../../../config/di/di.dart';
import '../../../../config/services/auth/user_manager.dart';
import '../../../../config/services/network/network_interface.dart';
import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/assets_strings.dart';

import '../../../../utils/constants.dart';
import '../../../common/buttons/solid/primary_icon_button.dart';
import '../cubit/edit_profile_cubit.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditProfileCubit>(context);
    final userImage = getItInstance.get<UserManager>().currentUser.image;
    final imageUrl = userImage != null
        ? getItInstance.get<INetworkService>().getFilesPath(userImage.path)
        : null;

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
                        margin: EdgeInsets.symmetric(vertical: AppSizesManager.p4),
                        clipBehavior: Clip.antiAlias,
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        width: MediaQuery.sizeOf(context).height * 0.2,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.bgDarken,
                            border: Border.all(color: AppColors.bgDarken2)),
                        child: _buildImageWidget(cubit, imageUrl)),
                Positioned(
                    bottom: AppSizesManager.s4,
                    right: AppSizesManager.s4 / 2,
                    child: Transform.scale(
                      scale: 0.7,
                      child: PrimaryIconButton(
                        icon: Icon(
                          cubit.pickedImage != null ? Iconsax.edit_2 : Iconsax.add,
                          color: Colors.white,
                        ),
                        isBordered: true,
                        borderColor: Colors.white,
                        onPressed: () {
                          cubit.pickUserImage();
                        },
                      ),
                    )),
                if (cubit.pickedImage != null)
                  Positioned(
                    top: AppSizesManager.s4,
                    right: AppSizesManager.s4 / 2,
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

  Widget _buildImageWidget(EditProfileCubit cubit, String? imageUrl) {
    // If user picked a new image, show it
    if (cubit.pickedImage != null) {
      return Image.file(
        File(cubit.pickedImage!.path),
        fit: BoxFit.cover,
      );
    }
    
    // If user has an existing profile image and hasn't removed it, show it
    if (imageUrl != null && !cubit.shouldRemoveImage) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) {
          return SvgPicture.asset(DrawableAssetStrings.defaultProfileImgIcon);
        },
      );
    }
    
    // Default placeholder when no image or image removed
    return SvgPicture.asset(DrawableAssetStrings.defaultProfileImgIcon);
  }
}
