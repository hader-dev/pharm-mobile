import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/chips/custom_chip.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/price_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../common/image/cached_network_image_with_asset_fallback.dart'
    show CachedNetworkImageWithDrawableFallback;

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    MedicineCatalogModel medicineCatalogData =
        BlocProvider.of<MedicineDetailsCubit>(context)
            .state
            .medicineCatalogData;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: context.responsiveAppSizeTheme.current.p16,
          horizontal: context.responsiveAppSizeTheme.current.p12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: CustomChip(
              label: medicineCatalogData.medicine.brandName,
              color: AppColors.bgDarken2,
              onTap: () {},
            ),
          ),
          const ResponsiveGap.s12(),
          Text(medicineCatalogData.medicine.dci,
              style: context.responsiveTextTheme.current.headLine2
                  .copyWith(fontSize: 23, fontWeight: FontWeight.w600)),
          const ResponsiveGap.s12(),
          TrademarkWidgetAlternate(),
        ],
      ),
    );
  }
}

class TrademarkWidgetAlternate extends StatelessWidget {
  const TrademarkWidgetAlternate({super.key});

  @override
  Widget build(BuildContext context) {
    MedicineCatalogModel catalogData =
        BlocProvider.of<MedicineDetailsCubit>(context)
            .state
            .medicineCatalogData;

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(
          RoutingManager.vendorDetails,
          extra: catalogData.company.id,
        );
      },
      child: Padding(
        padding:
            EdgeInsets.only(right: context.responsiveAppSizeTheme.current.s2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PriceWidget(
              price: catalogData.unitPriceHt,
              overridePrice: catalogData.computedPrice,
              mainStyle: context.responsiveTextTheme.current.headLine2.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.accent1Shade1),
              currencyStyle:
                  context.responsiveTextTheme.current.bodyXXSmall.copyWith(
                color: AppColors.accent1Shade1,
              ),
            ),
            const ResponsiveGap.s16(),
            Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                  ),
                  child:
                      CachedNetworkImageWithDrawableFallback.withErrorSvgImage(
                    imageUrl: getItInstance.get<INetworkService>().getFilesPath(
                        catalogData.company.thumbnailImage?.path ?? ""),
                    fit: BoxFit.cover,
                    errorImgSize:
                        context.responsiveAppSizeTheme.current.iconSize14,
                  ),
                ),
                const ResponsiveGap.s8(),
                Text(catalogData.company.name,
                    style: context.responsiveTextTheme.current.body3Regular
                        .copyWith()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
