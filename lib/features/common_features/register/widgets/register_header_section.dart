import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/register/cubit/register_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class RegisterHeaderSection extends StatelessWidget {
  const RegisterHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final state = cubit.state;
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          const ResponsiveGap.s24(),
          Text(
            context.translation!.create_account,
            style: context.responsiveTextTheme.current.headLine1.copyWith(
                fontSize: AppSizesManager.p24, color: AppColors.accent1Shade1),
          ),
          const ResponsiveGap.s8(),
          Text(
            context.translation!.welcome_back,
            style: context.responsiveTextTheme.current.body3Regular
                .copyWith(color: TextColors.ternary.color),
          ),
          const ResponsiveGap.s24(),
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
                    child: state.pickedImage != null
                        ? Image.file(
                            File(state.pickedImage!.path),
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
}
