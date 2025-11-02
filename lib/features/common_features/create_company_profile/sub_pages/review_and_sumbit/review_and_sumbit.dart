import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/cubit/create_company_profile_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import 'widgets/info_row.dart';

class ReviewSubmitPage extends StatelessWidget {
  final scrollController = ScrollController();
  ReviewSubmitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveAppSizeTheme.current.p8),
      child: Scrollbar(
        controller: scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.responsiveAppSizeTheme.current.p8),
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  width: MediaQuery.sizeOf(context).height * 0.2,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.bgDarken,
                      border: Border.all(color: AppColors.bgDarken2)),
                  child: BlocProvider.of<CreateCompanyProfileCubit>(context)
                              .companyData
                              .logoPath !=
                          null
                      ? Image.file(
                          File(BlocProvider.of<CreateCompanyProfileCubit>(
                                  context)
                              .companyData
                              .logoPath!),
                          fit: BoxFit.fill,
                        )
                      : const Icon(Iconsax.camera,
                          color: Colors.white, size: 40),
                ),
                // Container(
                //   height: 112,
                //   width: 112,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.blue,
                //   ),
                //   child: const Icon(Icons.local_pharmacy, color: Colors.white, size: 40),
                // ),
                const ResponsiveGap.s24(),

                // Company Info
                Text(
                    BlocProvider.of<CreateCompanyProfileCubit>(context)
                        .companyData
                        .companyName,
                    style: context.responsiveTextTheme.current.headLine2),

                const ResponsiveGap.s4(),
                Text(
                    CompanyType.values
                        .where((e) =>
                            e.id ==
                            BlocProvider.of<CreateCompanyProfileCubit>(context)
                                .companyData
                                .companyType)
                        .first
                        .name,
                    style: context.responsiveTextTheme.current.body1Medium
                        .copyWith(color: TextColors.ternary.color)),
                const ResponsiveGap.s12(),

                Text(
                  "${BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.description}.",
                  textAlign: TextAlign.center,
                  style: context.responsiveTextTheme.current.body2Regular
                      .copyWith(color: TextColors.ternary.color),
                ),
                const ResponsiveGap.s24(),

                // General information
                InfoRow(
                    icon: Icons.email,
                    label: context.translation!.email,
                    dataValue:
                        BlocProvider.of<CreateCompanyProfileCubit>(context)
                            .companyData
                            .email),
                InfoRow(
                    icon: Icons.phone,
                    label: context.translation!.phone_number,
                    dataValue:
                        BlocProvider.of<CreateCompanyProfileCubit>(context)
                            .companyData
                            .phone),
                InfoRow(
                    icon: Icons.language,
                    label: context.translation!.website,
                    dataValue:
                        BlocProvider.of<CreateCompanyProfileCubit>(context)
                            .companyData
                            .website),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: context.responsiveAppSizeTheme.current.p16),
                  child: Divider(
                    color: StrokeColors.normal.color,
                  ),
                ),

                // Legal information

                InfoRow(
                    label: context.translation!.nis,
                    dataValue:
                        BlocProvider.of<CreateCompanyProfileCubit>(context)
                            .companyData
                            .nis),
                InfoRow(
                    label: context.translation!.rc,
                    dataValue:
                        BlocProvider.of<CreateCompanyProfileCubit>(context)
                            .companyData
                            .rc),
                InfoRow(
                    label: context.translation!.ai,
                    dataValue:
                        BlocProvider.of<CreateCompanyProfileCubit>(context)
                            .companyData
                            .ai),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
