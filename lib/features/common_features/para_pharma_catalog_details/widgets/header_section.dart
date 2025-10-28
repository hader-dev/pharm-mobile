import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    ParaPharmaCatalogModel paraPharmaCatalogData =
        BlocProvider.of<ParaPharmaDetailsCubit>(context)
            .state
            .paraPharmaCatalogData;

    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSizesManager.p16, horizontal: AppSizesManager.p12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(paraPharmaCatalogData.name,
              style: context.responsiveTextTheme.current.headLine2),
          const ResponsiveGap.s12(),
          Row(children: [
            Icon(
              Iconsax.money_4,
              color: SystemColors.defaultState.primary,
            ),
            const ResponsiveGap.s4(),
            Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: paraPharmaCatalogData.unitPriceHt.formatAsPrice(),
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
          const ResponsiveGap.s12(),
        ],
      ),
    );
  }
}
