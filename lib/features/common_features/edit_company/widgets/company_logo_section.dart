import 'dart:io' show File;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/cubit/edit_company_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class CompanyLogoSection extends StatelessWidget {
  const CompanyLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditCompanyCubit>(context);
    final state = cubit.state;
    final companyImage = state.companyData.image;
    final imageUrl = companyImage != null
        ? getItInstance.get<INetworkService>().getFilesPath(companyImage.path)
        : null;

    final imageSize = MediaQuery.of(context).size.width > 600
        ? MediaQuery.of(context).size.height * 0.18
        : MediaQuery.of(context).size.height * 0.14;

    return BlocBuilder<EditCompanyCubit, EditCompanyState>(
      builder: (context, state) {
        return MaterialButton(
          onPressed: cubit.pickCompanyLogo,
          child: Column(
            children: [
              Text(
                context.translation!.companyLogo,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: TextColors.ternary.color,
                    ),
              ),
              const ResponsiveGap.s16(),
              Stack(
                children: [
                  Container(
                    height: imageSize,
                    width: imageSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.bgDarken,
                      border: Border.all(
                        color: AppColors.bgDarken2,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: state.pickedImage != null
                          ? Image.file(
                              File(state.pickedImage!.path),
                              fit: BoxFit.cover,
                            )
                          : imageUrl != null && !state.shouldRemoveImage
                              ? CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: AppColors.bgDarken,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: AppColors.bgDarken,
                                    child: const Icon(
                                      Iconsax.building,
                                      size: AppSizesManager.iconSize48,
                                      color: AppColors.accent1Shade1,
                                    ),
                                  ),
                                )
                              : Container(
                                  color: AppColors.bgDarken,
                                  child: const Icon(
                                    Iconsax.building,
                                    size: AppSizesManager.iconSize48,
                                    color: AppColors.accent1Shade1,
                                  ),
                                ),
                    ),
                  ),
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
                          cubit.pickCompanyLogo();
                        },
                      ),
                    ),
                  ),
                  if (state.pickedImage != null)
                    Positioned(
                      top: AppSizesManager.s4,
                      right: AppSizesManager.s4 / 2,
                      child: Transform.scale(
                        scale: 0.7,
                        child: PrimaryIconButton(
                          isBordered: true,
                          borderColor: Colors.white,
                          icon: const Icon(
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
            ],
          ),
        );
      },
    );
  }
}
