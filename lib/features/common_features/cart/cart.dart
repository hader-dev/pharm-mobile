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
                          text: " (${state.cartItems.length})",
                          style: context.responsiveTextTheme.current.bodySmall
                              .copyWith(
                                  color: AppColors.accent1Shade2Deemphasized)),
                    ],
                  ),
                );
              },
            ),
          ),
          body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
            final cubit = context.read<CartCubit>();

            if (state is CartLoading) {
              return Center(child: const CircularProgressIndicator());
            }
            if (state.cartItems.isEmpty) {
              return EmptyListWidget(
                onRefresh: () {
                  cubit.getCartItem();
                },
              );
            }

            final widgets = [
              ...state.cartItemsByVendor.keys.map((vendor) => VendorCartSection(
                    vendorData: state.cartItems
                        .firstWhere((element) =>
                            element.model.sellerCompanyId == vendor)
                        .model
                        .sellerCompany,
                    cartItems: state.cartItemsByVendor[vendor] ?? [],
                  )),
            ];
            return RefreshIndicator(
              onRefresh: () {
                return cubit.getCartItem();
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                        controller: cubit.scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: widgets),
                  ),
                  CartSummarySection()
                ],
              ),
            );
            // if (state is LoadingMoreOrders) const Center(child: CircularProgressIndicator()),
            // if (state is OrdersLoadLimitReached) EndOfLoadResultWidget(),
          }),
        ),
      ),
    );
  }
}
