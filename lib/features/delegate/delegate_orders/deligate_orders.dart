import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/shimmers/order_widget_shimmer.dart' show OrderWidgetShimmer;
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_orders/widgets/create_order_button.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_orders/widgets/search_widget.dart';
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
              const DelegateOrdersSearchWidget(),
              Expanded(
                child: BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
                  var cubit = context.read<OrdersCubit>();
                  if (state is OrdersLoading) {
                    return ListView(shrinkWrap: true, children: List.generate(4, (_) => OrderWidgetShimmer()));
                  }
                  if (state.orders.isEmpty) {
                    return EmptyListWidget(
                      onRefresh: () {
                        cubit.getOrders(
                          filters: state.filters,
                        );
                      },
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () => cubit.getOrders(),
                    child: ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        return DelegateOrderCard(
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
