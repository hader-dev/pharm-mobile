import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review&submit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../../models/para_pharma.dart';
import '../../../../utils/assets_strings.dart';
import '../cubit/para_pharma_details_cubit.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    ParaPharmaCatalogModel paraPharmaCatalogData =
        BlocProvider.of<ParaPharmaDetailsCubit>(context).paraPharmaCatalogData!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p16, horizontal: AppSizesManager.p12),
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
                      image: paraPharmaCatalogData.company!.image == null
                          ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                          : NetworkImage(paraPharmaCatalogData.company!.thumbnailImage),
                    ),
                  ),
                ),
                Gap(AppSizesManager.s4),
                Text(paraPharmaCatalogData.company!.name, style: AppTypography.body3RegularStyle),
              ],
            ),
          Text(paraPharmaCatalogData.name, style: AppTypography.headLine2Style),
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
                  text: double.parse(paraPharmaCatalogData.unitPriceHt).formatAsPrice(),
                  style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.accent1Shade1),
                ),
                TextSpan(
                  text: " DZD",
                  style: AppTypography.bodyXSmallStyle.copyWith(color: AppColors.accent1Shade1),
                ),
              ],
            ))
          ]),
          Gap(AppSizesManager.s12),
          InfoRow(label: "Available quantity", dataValue: "${paraPharmaCatalogData.stockQuantity.toString()} unit"),
        ],
      ),
    );
  }
}
