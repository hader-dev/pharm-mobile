import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../config/theme/colors_manager.dart';
import '../../../../../models/para_pharma.dart';
import '../../../../../utils/constants.dart';
import '../../cubit/para_pharma_details_cubit.dart';

class ParaPharmaOverViewPage extends StatelessWidget {
  const ParaPharmaOverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    ParaPharmaCatalogModel paraPharmaCatalogData =
        BlocProvider.of<ParaPharmaDetailsCubit>(context).paraPharmaCatalogData!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(color: AppColors.accent1Shade1),
            ),
            Gap(AppSizesManager.s12),
            Flexible(
              child: Text(
                paraPharmaCatalogData.description,
                softWrap: true,
                style: context.responsiveTextTheme.current.body2Regular,
              ),
            ),
            Gap(AppSizesManager.s12),
            Row(
              children: [
                Icon(Icons.check_box, color: AppColors.accentGreenShade2),
                Gap(AppSizesManager.s8),
                Text(
                  'Specifications',
                  style: context.responsiveTextTheme.current.headLine3SemiBold,
                ),
              ],
            ),
            Gap(AppSizesManager.s16),
            InfoRow(
              label: 'Category',
              dataValue: paraPharmaCatalogData.category.name,
            ),
            InfoRow(
              label: 'brand',
              dataValue: paraPharmaCatalogData.brand.name,
            ),
            InfoRow(
              label: 'Packaging',
              dataValue: paraPharmaCatalogData.packaging,
            ),
          ]),
    );
  }
}
