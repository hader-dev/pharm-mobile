import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    ParaPharmaCatalogModel paraPharmaCatalogData =
        BlocProvider.of<ParaPharmaDetailsCubit>(context).paraPharmaCatalogData!;
    final translation = context.translation!;

    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSizesManager.p16, horizontal: AppSizesManager.p12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(AppSizesManager.s12),
          if (paraPharmaCatalogData.company != null)
            Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                    image: DecorationImage(
                      image: paraPharmaCatalogData
                                  .company?.thumbnailImage?.path ==
                              null
                          ? AssetImage(
                              DrawableAssetStrings.companyPlaceHolderImg)
                          : NetworkImage(
                              getItInstance.get<INetworkService>().getFilesPath(
                                    paraPharmaCatalogData
                                        .company!.thumbnailImage!.path,
                                  ),
                            ),
                    ),
                  ),
                ),
                Gap(AppSizesManager.s4),
                Text(paraPharmaCatalogData.company!.name,
                    style: context.responsiveTextTheme.current.body3Regular),
              ],
            ),
          Text(paraPharmaCatalogData.name,
              style: context.responsiveTextTheme.current.headLine2),
          Gap(AppSizesManager.s12),
          Row(children: [
            Spacer(),
            Icon(
              Iconsax.money_4,
              color: SystemColors.defaultState.primary,
            ),
            Gap(AppSizesManager.s4),
            Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: double.parse(paraPharmaCatalogData.unitPriceHt)
                      .formatAsPrice(),
                  style: context.responsiveTextTheme.current.headLine3SemiBold
                      .copyWith(color: AppColors.accent1Shade1),
                ),
                TextSpan(
                  text:
                      " ${RoutingManager.rootNavigatorKey.currentContext!.translation!.currency}",
                  style: context.responsiveTextTheme.current.bodyXSmall
                      .copyWith(color: AppColors.accent1Shade1),
                ),
              ],
            ))
          ]),
          Gap(AppSizesManager.s12),
          InfoRow(
              label: translation.quantity,
              dataValue: paraPharmaCatalogData.stockQuantity.toString()),
        ],
      ),
    );
  }
}
