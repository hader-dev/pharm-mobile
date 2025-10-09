import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/widgets/cart_summary.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import 'cubit/cart_cubit.dart';
import 'widgets/vendor_cart_items_set.dart';

class CartScreen extends StatelessWidget {
  final bool isInHome;
  const CartScreen({super.key, this.isInHome = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>(),
        child: Scaffold(
          appBar: CustomAppBarV2.alternate(
            topPadding: MediaQuery.of(context).padding.top,
            bottomPadding: MediaQuery.of(context).padding.bottom,
            leading: IconButton(
              icon: const Icon(
                Iconsax.bag_2,
                size: AppSizesManager.iconSize25,
                color: AppColors.bgWhite,
              ),
              onPressed: () {},
            ),
            title: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Text.rich(
                  TextSpan(
                    text: context.translation!.cart,
                    style: context.responsiveTextTheme.current.headLine3SemiBold
                        .copyWith(color: AppColors.bgWhite),
                    children: [
                      TextSpan(
                          text:
                              " (${BlocProvider.of<CartCubit>(context).cartItems.length})",
                          style: context.responsiveTextTheme.current.bodySmall
                              .copyWith(
                                  color: AppColors.accent1Shade2Deemphasized)),
                    ],
                  ),
                );
              },
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                if (state is CartLoading) {
                  return Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator()),
                  );
                }
                if (BlocProvider.of<CartCubit>(context).cartItems.isEmpty) {
                  return Expanded(
                    child: EmptyListWidget(
                      onRefresh: () {
                        BlocProvider.of<CartCubit>(context).getCartItem();
                      },
                    ),
                  );
                }
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return BlocProvider.of<CartCubit>(context).getCartItem();
                    },
                    child: ListView(
                        controller: BlocProvider.of<CartCubit>(context)
                            .scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: BlocProvider.of<CartCubit>(context)
                            .cartItemsByVendor
                            .keys
                            .map((vendor) => VendorCartSection(
                                  vendorData:
                                      BlocProvider.of<CartCubit>(context)
                                          .cartItems
                                          .firstWhere((element) =>
                                              element.model.sellerCompanyId ==
                                              vendor)
                                          .model
                                          .sellerCompany,
                                  cartItems: BlocProvider.of<CartCubit>(context)
                                          .cartItemsByVendor[vendor] ??
                                      [],
                                ))
                            .toList()),
                  ),
                );
                // if (state is LoadingMoreOrders) const Center(child: CircularProgressIndicator()),
                // if (state is OrdersLoadLimitReached) EndOfLoadResultWidget(),
              }),
              CartSummarySection()
            ],
          ),
        ),
      ),
    );
  }
}
