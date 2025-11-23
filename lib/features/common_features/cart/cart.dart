import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/widgets/cart_item_v4.dart' show CartItemWidgetV4;
import 'package:hader_pharm_mobile/features/common_features/cart/widgets/cart_summary_v1.dart';

import 'cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  final bool isInHome;

  const CartScreen({super.key, this.isInHome = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>(),
        child: Scaffold(
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
                        children: state.cartItems
                            .map((item) => CartItemWidgetV4(
                                  item: item,
                                ))
                            .toList()),
                  ),
                  CartSummarySectionV1()
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
