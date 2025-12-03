import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/chips/custom_chip.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/price_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/widgets/quantity/cart_item_quantity_section.dart'
    show CartQuantitySection;
import 'package:hader_pharm_mobile/models/cart_item.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../common/buttons/solid/primary_icon_button.dart' show PrimaryIconButton;

class CartItemWidgetV4 extends StatelessWidget {
  final CartItemModelUi item;

  const CartItemWidgetV4({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final imageItem = getItInstance.get<INetworkService>().getFilesPath(item.model.image?.path ?? "");

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(bottom: context.responsiveAppSizeTheme.current.p8),
            child: Transform.scale(
              alignment: Alignment.topCenter,
              scale: .95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p8),
                        clipBehavior: Clip.antiAlias,
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(219, 245, 245, 245),
                          border: Border.all(
                            color: const Color.fromARGB(186, 245, 245, 245),
                          ),
                          borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
                        ),
                        child: CachedNetworkImageWithDrawableFallback.withErrorSvgImage(
                          fit: BoxFit.fitWidth,
                          height: double.infinity,
                          imageUrl: imageItem,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.model.designation,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.responsiveTextTheme.current.headLine5Medium,
                                  ),
                                ),
                                Transform.scale(
                                  alignment: Alignment.topRight,
                                  scale: .75,
                                  child: PrimaryIconButton(
                                    isBordered: false,
                                    bgColor: SystemColors.red.primary.withAlpha(20),
                                    onPressed: () {
                                      cartCubit.deleteCartItem(item);
                                    },
                                    icon: Icon(LucideIcons.trash,
                                        size: context.responsiveAppSizeTheme.current.iconSize20,
                                        color: SystemColors.red.primary),
                                  ),
                                )
                              ],
                            ),
                            ResponsiveGap.s2(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                PriceWidget(
                                    price: double.parse(item.model.unitPriceHt),
                                    overridePrice: double.parse(item.model.appliedAmountHt)),
                                const Spacer(),
                                BlocBuilder<CartCubit, CartState>(
                                  builder: (context, state) {
                                    return CartQuantitySection(
                                      displayQuantityLabel: false,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      decrement: () => cartCubit.decreaseCartItemQuantity(item),
                                      increment: () => cartCubit.increaseCartItemQuantity(item),
                                      quantityController: item.quantityController,
                                      onQuantityChanged: (value) => cartCubit.updateItemQuantity(item),
                                      maxQuantity: item.model.maxOrderQuantity,
                                      minQuantity: item.model.minOrderQuantity,
                                    );
                                  },
                                ),
                              ],
                            ),
                            ResponsiveGap.s8(),
                            if (double.parse(item.packageQuantityController.text) > 0)
                              Row(
                                children: [
                                  CustomChip(
                                    labelStyle: context.responsiveTextTheme.current.bodyXXSmall,
                                    labelColor: Color.fromARGB(255, 26, 152, 161),
                                    icon: Iconsax.box_1,
                                    label:
                                        "${context.translation!.package}${" (${item.packageQuantityController.text})"}",
                                    color: const Color.fromARGB(255, 26, 152, 161).withAlpha(50),
                                  ),
                                ],
                              ),
                            ...[
                              ResponsiveGap.s6(),
                              InkWell(
                                onTap: () => RoutingManager.router
                                    .pushNamed(RoutingManager.vendorDetails, extra: item.model.sellerCompany.id),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 100),
                                      child: Text(
                                        item.model.sellerCompany.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.responsiveTextTheme.current.bodySmall,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: context.responsiveAppSizeTheme.current.iconSize16,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ],
                        ),
                      )
                    ],
                  ),
                  AppDivider(
                    color: Colors.grey.shade100,
                    indent: context.responsiveAppSizeTheme.current.p8,
                    endIndent: context.responsiveAppSizeTheme.current.p8,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
