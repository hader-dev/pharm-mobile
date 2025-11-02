import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/chips/custom_chip.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

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
          Row(
            children: [
              IntrinsicWidth(
                child: CustomChip(
                  label: medicineCatalogData.medicine.brandName,
                  color: AppColors.bgDarken2,
                  onTap: () {},
                ),
              ),
              const Spacer(),
              Icon(
                Icons.calendar_month,
                color: Colors.grey[700],
                size: context.responsiveAppSizeTheme.current.iconSize30,
              ),
              const ResponsiveGap.s4(),
              Text(
                medicineCatalogData.createdAt.formatDMY(context.translation!),
                style: context.responsiveTextTheme.current.body3Regular
                    .copyWith(
                        color: TextColors.ternary.color,
                        fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const ResponsiveGap.s12(),
          Text(medicineCatalogData.dci ?? "No dci Available",
              style: context.responsiveTextTheme.current.headLine2),
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
    final translation = context.translation!;

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
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                image: DecorationImage(
                  image: catalogData.company.thumbnailImage?.path == null
                      ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                      : NetworkImage(
                          getItInstance.get<INetworkService>().getFilesPath(
                                catalogData.company.thumbnailImage!.path,
                              ),
                        ),
                ),
              ),
            ),
            const ResponsiveGap.s4(),
            Text(catalogData.company.name,
                style: context.responsiveTextTheme.current.body3Regular
                    .copyWith()),
            const Spacer(),
            Icon(
              Iconsax.dollar_circle4,
              color: AppColors.accent1Shade1,
              size: context.responsiveAppSizeTheme.current.iconSize30,
            ),
            const ResponsiveGap.s4(),
            Text(
              "${catalogData.unitPriceHt.formatAsPrice()} ${translation.currency}",
              style: context.responsiveTextTheme.current.body1Regular.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.accent1Shade1),
            )
          ],
        ),
      ),
    );
  }
}
