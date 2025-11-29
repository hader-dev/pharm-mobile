import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart'
    show CachedNetworkImageWithDrawableFallback;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/price_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class TrademarkWidget extends StatelessWidget {
  const TrademarkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ParaPharmaCatalogModel catalogData = BlocProvider.of<ParaPharmaDetailsCubit>(context).state.paraPharmaCatalogData;

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
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p4),
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
                  style: context.responsiveTextTheme.current.body3Regular.copyWith(color: Colors.white)),
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
    ParaPharmaCatalogModel catalogData = BlocProvider.of<ParaPharmaDetailsCubit>(context).state.paraPharmaCatalogData;

    return Padding(
      padding: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.s2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PriceWidget(
            price: catalogData.unitPriceHt,
            overridePrice: catalogData.computedPrice,
            mainStyle: context.responsiveTextTheme.current.headLine2
                .copyWith(fontWeight: FontWeight.bold, color: AppColors.accent1Shade1),
            currencyStyle: context.responsiveTextTheme.current.bodyXXSmall.copyWith(
              color: AppColors.accent1Shade1,
            ),
          ),
          const ResponsiveGap.s16(),
          GestureDetector(
              onTap: () {
                GoRouter.of(context).pushNamed(
                  RoutingManager.vendorDetails,
                  extra: catalogData.company!.id,
                );
              },
              child: Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                    ),
                    child: CachedNetworkImageWithDrawableFallback.withErrorSvgImage(
                      imageUrl: getItInstance
                          .get<INetworkService>()
                          .getFilesPath(catalogData.company?.thumbnailImage?.path ?? ""),
                      fit: BoxFit.cover,
                      errorImgSize: context.responsiveAppSizeTheme.current.iconSize14,
                    ),
                  ),
                  const ResponsiveGap.s8(),
                  Text(catalogData.company!.name, style: context.responsiveTextTheme.current.body3Regular.copyWith()),
                ],
              )),
        ],
      ),
    );
  }
}
