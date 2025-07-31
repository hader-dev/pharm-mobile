import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/cubit/create_company_profile_cubit.dart' show CreateCompanyProfileState, CreateCompanyProfileCubit;
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';


class PharmacyProfilePage extends StatefulWidget {
  const PharmacyProfilePage({super.key});

  @override
  State<PharmacyProfilePage> createState() => _PharmacyProfilePageState();
}

class _PharmacyProfilePageState extends State<PharmacyProfilePage> with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
      child: Scrollbar(
        controller: scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<CreateCompanyProfileCubit, CreateCompanyProfileState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(context.translation!.logo,
                            style: AppTypography.body3MediumStyle.copyWith(color: TextColors.ternary.color))),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSizesManager.p24),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<CreateCompanyProfileCubit>(context).pickGalleryImage();
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
                                child: BlocProvider.of<CreateCompanyProfileCubit>(context).pickedImage != null
                                    ? Image.file(
                                        File(BlocProvider.of<CreateCompanyProfileCubit>(context).pickedImage!.path),
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
                                    //           label: BlocProvider.of<CreateCompanyProfileCubit>(context).pickedImage != null
                                    //               ? 'Change Image'
                                    //               : 'Upload Image',
                                    //           labelColor: AppColors.accent1Shade1,
                                    //           color: AppColors.bgWhite,
                                    //           onTap: () {
                                    //             if (BlocProvider.of<CreateCompanyProfileCubit>(context).pickedImage != null) {
                                    //               BlocProvider.of<CreateCompanyProfileCubit>(context).removeImage();
                                    //             }
                                    //             BlocProvider.of<CreateCompanyProfileCubit>(context).pickUserImage();
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
                                      BlocProvider.of<CreateCompanyProfileCubit>(context).pickedImage != null
                                          ? Iconsax.edit_2
                                          : Iconsax.add,
                                      color: Colors.white,
                                    ),
                                    isBordered: true,
                                    borderColor: Colors.white,
                                    onPressed: () {
                                      BlocProvider.of<CreateCompanyProfileCubit>(context).pickGalleryImage();
                                    },
                                  ),
                                )),
                            if (BlocProvider.of<CreateCompanyProfileCubit>(context).pickedImage != null)
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
                                      BlocProvider.of<CreateCompanyProfileCubit>(context).removeImage();
                                    },
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    Gap(AppSizesManager.s16),
                    CustomTextField(
                      label: context.translation!.description,
                      state: FieldState.normal,
                      maxLines: 8,
                      validationFunc: () {},
                      value: BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.description,
                      onChanged: (newValue) {
                        BlocProvider.of<CreateCompanyProfileCubit>(context).changeCompanyData(
                            modifiedData: BlocProvider.of<CreateCompanyProfileCubit>(context)
                                .companyData
                                .copyWith(description: newValue));
                      },
                    ),
                    
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
