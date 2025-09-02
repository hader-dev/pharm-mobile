import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/theme/colors_manager.dart';
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
                    child:
                        BlocProvider.of<RegisterCubit>(context).pickedImage !=
                                null
                            ? Image.file(
                                File(BlocProvider.of<RegisterCubit>(context)
                                    .pickedImage!
                                    .path),
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
                          BlocProvider.of<RegisterCubit>(context).pickedImage !=
                                  null
                              ? Iconsax.edit_2
                              : Iconsax.add,
                          color: Colors.white,
                        ),
                        isBordered: true,
                        borderColor: Colors.white,
                        onPressed: () {
                          BlocProvider.of<RegisterCubit>(context)
                              .pickUserImage();
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
