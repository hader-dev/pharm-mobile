import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders/widgets/create_order_button.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_provider.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/widget/order_card.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class DeligateOrdersScreen extends StatelessWidget {
  const DeligateOrdersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrdersProviderState(
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
            title: Text(
              context.translation!.orders,
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(color: AppColors.bgWhite),
            ),
          ),
          floatingActionButton: const CreateOrderButton(),
          body:
              BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
            if (state.orders.isEmpty) {
              return RefreshIndicator(
                onRefresh: () => context.read<OrdersCubit>().getOrders(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: EmptyListWidget(),
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () => context.read<OrdersCubit>().getOrders(),
              child: ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return OrderCard(
                    orderData: order,
                    displayClientCompanyOrVendor: true,
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
