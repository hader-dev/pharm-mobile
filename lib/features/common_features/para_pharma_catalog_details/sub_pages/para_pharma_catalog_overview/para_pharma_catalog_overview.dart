import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review&submit/widgets/info_row.dart';

import '../../../../../config/theme/colors_manager.dart';
import '../../../../../config/theme/typoghrapy_manager.dart';

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
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Description',
          style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.accent1Shade1),
        ),
        Gap(AppSizesManager.s12),
        Flexible(
          child: Text(
            paraPharmaCatalogData.description,
            softWrap: true,
            style: AppTypography.body2RegularStyle,
          ),
        ),
        Gap(AppSizesManager.s12),
        Row(
          children: [
            Icon(Icons.check_box, color: AppColors.accentGreenShade2),
            Gap(AppSizesManager.s8),
            Text(
              'Specifications',
              style: AppTypography.headLine3SemiBoldStyle,
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
