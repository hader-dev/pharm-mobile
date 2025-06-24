import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../config/theme/colors_manager.dart';
import '../../../../config/theme/typoghrapy_manager.dart';

import '../../../../utils/constants.dart';
import '../../../common/buttons/solid/primary_icon_button.dart';
import '../cubit/register_cubit.dart';

class RegisterHeaderSection extends StatelessWidget {
  const RegisterHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Gap(AppSizesManager.s24),
          Text(
            'Create Account',
            style: AppTypography.headLine1Style.copyWith(fontSize: AppSizesManager.p24, color: AppColors.accent1Shade1),
          ),
          Gap(AppSizesManager.s8),
          Text(
            'Hi! Welcome back, you’ve been missed',
            style: AppTypography.body3RegularStyle.copyWith(color: TextColors.ternary.color),
          ),
          Gap(AppSizesManager.s24),
          InkWell(
            onTap: () {
              BlocProvider.of<RegisterCubit>(context).pickUserImage();
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
                    child: BlocProvider.of<RegisterCubit>(context).pickedImage != null
                        ? Image.file(
                            File(BlocProvider.of<RegisterCubit>(context).pickedImage!.path),
                            fit: BoxFit.fill,
                          )
                        // : Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       const Icon(Iconsax.gallery_add,
                        //           color: AppColors.accent1Shade1, size: AppSizesManager.iconSize25),
                        //       Gap(AppSizesManager.s4),
                        //       Transform.scale(
                        //         scale: 0.8,
                        //         child: PrimaryTextButton(
                        //           label: BlocProvider.of<RegisterCubit>(context).pickedImage != null
                        //               ? 'Change Image'
                        //               : 'Upload Image',
                        //           labelColor: AppColors.accent1Shade1,
                        //           color: AppColors.bgWhite,
                        //           onTap: () {
                        //             if (BlocProvider.of<RegisterCubit>(context).pickedImage != null) {
                        //               BlocProvider.of<RegisterCubit>(context).removeImage();
                        //             }
                        //             BlocProvider.of<RegisterCubit>(context).pickUserImage();
                        //           },
                        //         ),
                        //       )
                        //     ],
                        //   ),
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
                          BlocProvider.of<RegisterCubit>(context).pickedImage != null ? Iconsax.edit_2 : Iconsax.add,
                          color: Colors.white,
                        ),
                        isBordered: true,
                        borderColor: Colors.white,
                        onPressed: () {
                          BlocProvider.of<RegisterCubit>(context).pickUserImage();
                        },
                      ),
                    )),
                if (BlocProvider.of<RegisterCubit>(context).pickedImage != null)
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
                          BlocProvider.of<RegisterCubit>(context).removeImage();
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
