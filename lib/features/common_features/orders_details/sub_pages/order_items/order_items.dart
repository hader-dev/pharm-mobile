import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/sub_pages/order_items/widgets/order_items_section.dart';

class OrderDetailsItemsPage extends StatelessWidget {
  const OrderDetailsItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
        builder: (context, state) {
      if (state is OrderDetailsLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is OrderDetailsLoadingFailed) {
        return const EmptyListWidget();
      }
      return SingleChildScrollView(
          child: OrderItemsSection(
              orderItems:
                  context.read<OrderDetailsCubit>().orderData!.orderItems));
    });
  }
}
