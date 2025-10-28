import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders/widgets/create_order_button.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders/widgets/search_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_provider.dart';

import 'widgets/order_card.dart';

class DeligateOrdersScreen extends StatelessWidget {
  const DeligateOrdersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrdersProviderState(
        child: Scaffold(
          floatingActionButton: const CreateOrderButton(),
          body: Column(
            children: [
              const DeligateOrdersSearchWidget(),
              Expanded(
                child: BlocBuilder<OrdersCubit, OrdersState>(
                    builder: (context, state) {
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
            ],
          ),
        ),
      ),
    );
  }
}
