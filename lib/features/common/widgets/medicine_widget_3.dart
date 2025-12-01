import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart' show PrimaryTextButton;
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart'
    show CachedNetworkImageWithDrawableFallback;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/price_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/stock_availlable.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/quick_add_modal.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

typedef OnFavoriteCallback = void Function(BaseMedicineCatalogModel medicine);

class MedicineWidget3 extends StatelessWidget {
  final BaseMedicineCatalogModel medicineData;
  final OnFavoriteCallback? onFavoriteCallback;
  final String route;
  const MedicineWidget3(
      {super.key,
      this.route = RoutingManager.medicineDetailsScreen,
      required this.medicineData,
      this.onFavoriteCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.responsiveAppSizeTheme.current.p8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(186, 245, 245, 245),
        ),
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          final userRole = getItInstance.get<UserManager>().currentUser.role;
          final canOrderBasedOnRole = !userRole.isDelegate;
          GoRouter.of(context).pushNamed(route, extra: {"id": medicineData.id, "canOrder": canOrderBasedOnRole});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _ImageSection(medicineData: medicineData, onFavoriteCallback: onFavoriteCallback),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.responsiveAppSizeTheme.current.p8,
                    horizontal: context.responsiveAppSizeTheme.current.p8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 27,
                          width: 27,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                            image: DecorationImage(
                              image: medicineData.company?.thumbnailImage?.path == null
                                  ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                                  : NetworkImage(
                                      getItInstance.get<INetworkService>().getFilesPath(
                                            medicineData.company!.thumbnailImage!.path,
                                          ),
                                    ),
                            ),
                          ),
                        ),
                        const ResponsiveGap.s4(),
                        Text(medicineData.company!.name,
                            style: context.responsiveTextTheme.current.body3Regular.copyWith()),
                      ],
                    ),
                    const ResponsiveGap.s4(),
                    if (medicineData.dci != null)
                      Tooltip(
                        message: medicineData.dci,
                        triggerMode: TooltipTriggerMode.longPress,
                        child: Text(medicineData.dci,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: context.responsiveTextTheme.current.headLine3SemiBold
                                .copyWith(color: TextColors.primary.color)),
                      ),
                    const ResponsiveGap.s4(),
                    PriceWidget(
                      price: medicineData.unitPriceHt,
                      overridePrice: medicineData.unitPriceHt,
                      mainStyle: context.responsiveTextTheme.current.headLine4SemiBold
                          .copyWith(color: AppColors.accent1Shade1),
                      currencyStyle: context.responsiveTextTheme.current.bodyXSmall
                          .copyWith(color: AppColors.accent1Shade1, fontSize: 10),
                    ),
                    const ResponsiveGap.s4(),
                    PrimaryTextButton(
                        label: context.translation!.add_cart,
                        leadingIcon: Iconsax.add,
                        labelTextStyle: context.responsiveTextTheme.current.body3Regular.copyWith(color: Colors.white),
                        onTap: () {
                          BottomSheetHelper.showCommonBottomSheet(
                              initialChildSize: .5,
                              context: context,
                              child: QuickCartAddModal(
                                medicineCatalogId: medicineData.id,
                                maxOrderQuantity: medicineData.maxOrderQuantity,
                                minOrderQuantity: medicineData.minOrderQuantity,
                              ));
                        },
                        color: AppColors.accent1Shade1),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({
    required this.medicineData,
    required this.onFavoriteCallback,
  });

  final BaseMedicineCatalogModel medicineData;
  final OnFavoriteCallback? onFavoriteCallback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(
          horizontal: context.responsiveAppSizeTheme.current.p6, vertical: context.responsiveAppSizeTheme.current.p6),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
        border: medicineData.image != null
            ? null
            : Border.all(
                color: const Color.fromARGB(197, 245, 245, 245),
              ),
      ),
      child: Stack(children: [
        CachedNetworkImageWithDrawableFallback.withErrorSvgImage(
          imageUrl: getItInstance.get<INetworkService>().getFilesPath(medicineData.image?.path ?? ''),
          width: double.infinity,
          height: double.infinity,
          errorStyle: context.responsiveTextTheme.current.bodyXSmall.copyWith(color: Colors.grey.shade400),
          errorMsg: "No Image Available",
          fit: BoxFit.cover,
        ),
        Row(
          children: [
            StockAvailableContainerWidget(isAvailable: medicineData.stockQuantity > 0),
            Spacer(),
            if (onFavoriteCallback != null)
              InkWell(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Icon(
                    medicineData.isLiked ? Iconsax.heart5 : Iconsax.heart,
                    color: medicineData.isLiked ? Colors.red : Colors.grey[400],
                    size: context.responsiveAppSizeTheme.current.iconSize20,
                  ),
                ),
                onTap: () {
                  onFavoriteCallback?.call(medicineData);
                },
              )
          ],
        ),
      ]),
    ));
  }
}
