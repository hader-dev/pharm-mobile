import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/quantity_section.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/models/cart_item.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class CartItemWidgetV3 extends StatelessWidget {
  final CartItemModelUi item;

  const CartItemWidgetV3({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final imageItem = getItInstance
        .get<INetworkService>()
        .getFilesPath(item.model.image?.path ?? "");

    final quantitySectionModified = QuantitySectionModified(
      disabledPackageQuantity: true,
      displayQuantityLabel: false,
      axis: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      decrementQuantity: () => cartCubit.decreaseCartItemQuantity(item),
      incrementQuantity: () => cartCubit.increaseCartItemQuantity(item),
      decrementPackageQuantity: () =>
          cartCubit.decreaseCartItemPackageQuantity(item),
      incrementPackageQuantity: () =>
          cartCubit.increaseCartItemPackageQuantity(item),
      quantityController: item.quantityController,
      onQuantityChanged: (value) => cartCubit.updateItemQuantity(item),
      onPackageQuantityChanged: (value) =>
          cartCubit.updateItemPackageQuantity(item),
      packageQuantityController: item.packageQuantityController,
    );

    final cartItemProductInfos = Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            item.model.designation,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: context.responsiveTextTheme.current.headLine5SemiBold,
          ),
          Text(
            "${context.translation!.package} ${item.packageQuantityController.text}",
            style: context.responsiveTextTheme.current.headLine4Medium
                .copyWith(color: Colors.grey),
          ),
          Text(
            "${(num.parse(item.model.unitPriceHt) * num.parse(item.quantityController.text)).toStringAsFixed(2)} ${context.translation!.currency}",
            style: context.responsiveTextTheme.current.headLine4Medium
                .copyWith(color: AppColors.accent1Shade1),
          ),
        ],
      ),
    );
    return AspectRatio(
      aspectRatio: context.isTabelet ? 2.5 : 16 / 9,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                cartCubit.deleteCartItem(item);
              },
              backgroundColor: Colors.red.withAlpha(40),
              foregroundColor: Colors.red,
              icon: Iconsax.trash,
              label: context.translation!.delete,
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: context.responsiveAppSizeTheme.current.p8,
              horizontal: context.responsiveAppSizeTheme.current.p4),
          padding: EdgeInsets.symmetric(
              vertical: context.responsiveAppSizeTheme.current.p10,
              horizontal: context.responsiveAppSizeTheme.current.p10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(
                context.responsiveAppSizeTheme.current.commonWidgetsRadius),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: CachedNetworkImageWithAssetFallback(
                    fit: BoxFit.fill,
                    height: double.infinity,
                    imageUrl: imageItem,
                    assetImage: DrawableAssetStrings.medicinePlaceHolderImg),
              ),
              const ResponsiveGap.s8(),
              Expanded(
                flex: 4,
                child: cartItemProductInfos,
              ),
              Expanded(
                child: quantitySectionModified,
              )
            ],
          ),
        ),
      ),
    );
  }
}
