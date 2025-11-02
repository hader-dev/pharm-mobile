import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

class TrademarkWidget extends StatelessWidget {
  const TrademarkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ParaPharmaCatalogModel catalogData =
        BlocProvider.of<ParaPharmaDetailsCubit>(context)
            .state
            .paraPharmaCatalogData;

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(
          RoutingManager.vendorDetails,
          extra: catalogData.company!.id,
        );
      },
      child: ColoredBox(
        color: AppColors.accent1Shade2.withAlpha(200),
        child: Padding(
          padding: const EdgeInsets.all(AppSizesManager.p4),
          child: Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                  image: DecorationImage(
                    image: catalogData.company?.thumbnailImage?.path == null
                        ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                        : NetworkImage(
                            getItInstance.get<INetworkService>().getFilesPath(
                                  catalogData.company!.thumbnailImage!.path,
                                ),
                          ),
                  ),
                ),
              ),
              const ResponsiveGap.s4(),
              Text(catalogData.company!.name,
                  style: context.responsiveTextTheme.current.body3Regular
                      .copyWith(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

class TrademarkWidgetAlternate extends StatelessWidget {
  const TrademarkWidgetAlternate({super.key});

  @override
  Widget build(BuildContext context) {
    ParaPharmaCatalogModel catalogData =
        BlocProvider.of<ParaPharmaDetailsCubit>(context)
            .state
            .paraPharmaCatalogData;
    final translation = context.translation!;

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(
          RoutingManager.vendorDetails,
          extra: catalogData.company!.id,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: AppSizesManager.s2),
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                image: DecorationImage(
                  image: catalogData.company?.thumbnailImage?.path == null
                      ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                      : NetworkImage(
                          getItInstance.get<INetworkService>().getFilesPath(
                                catalogData.company!.thumbnailImage!.path,
                              ),
                        ),
                ),
              ),
            ),
            const ResponsiveGap.s4(),
            Text(catalogData.company!.name,
                style: context.responsiveTextTheme.current.body3Regular
                    .copyWith()),
            const Spacer(),
            Icon(
              Iconsax.dollar_circle4,
              color: AppColors.accent1Shade1,
              size: AppSizesManager.iconSize30,
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
