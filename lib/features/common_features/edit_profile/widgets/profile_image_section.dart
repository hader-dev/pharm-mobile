import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iconsax/iconsax.dart';
import '../../../../config/theme/colors_manager.dart';

import '../../../../utils/constants.dart';
import '../../../common/buttons/solid/primary_icon_button.dart';
import '../cubit/edit_profile_cubit.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              BlocProvider.of<EditProfileCubit>(context).pickUserImage();
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
                    child: BlocProvider.of<EditProfileCubit>(context).pickedImage != null
                        ? Image.file(
                            File(BlocProvider.of<EditProfileCubit>(context).pickedImage!.path),
                            fit: BoxFit.fill,
                          )
                        : Icon(
                            Iconsax.gallery,
                            color: AppColors.accent1Shade1,
                            size: AppSizesManager.iconSize25,
                          )),
                Positioned(
                    bottom: AppSizesManager.s4,
                    right: AppSizesManager.s4 / 2,
                    child: Transform.scale(
                      scale: 0.7,
                      child: PrimaryIconButton(
                        icon: Icon(
                          BlocProvider.of<EditProfileCubit>(context).pickedImage != null ? Iconsax.edit_2 : Iconsax.add,
                          color: Colors.white,
                        ),
                        isBordered: true,
                        borderColor: Colors.white,
                        onPressed: () {
                          BlocProvider.of<EditProfileCubit>(context).pickUserImage();
                        },
                      ),
                    )),
                if (BlocProvider.of<EditProfileCubit>(context).pickedImage != null)
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
                          BlocProvider.of<EditProfileCubit>(context).removeImage();
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
}
