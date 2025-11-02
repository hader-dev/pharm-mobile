import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';

import 'cubit/orders_cubit.dart';
import 'widget/order_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value:
            AppLayout.appLayoutScaffoldKey.currentContext!.read<OrdersCubit>(),
        child: SafeArea(
          child: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              if (state is OrdersLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.orders.isEmpty) {
                return EmptyListWidget(
                  onRefresh: () {
                    BlocProvider.of<OrdersCubit>(context).getOrders();
                  },
                );
              }

              return RefreshIndicator(
                onRefresh: () {
                  return BlocProvider.of<OrdersCubit>(context).getOrders();
                },
                child: ListView.builder(
                  controller:
                      BlocProvider.of<OrdersCubit>(context).scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.orders.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.orders.length) {
                      return OrderCard(orderData: state.orders[index]);
                    } else {
                      if (state is LoadingMoreOrders) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (state is OrdersLoadLimitReached) {
                        return const EndOfLoadResultWidget();
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
