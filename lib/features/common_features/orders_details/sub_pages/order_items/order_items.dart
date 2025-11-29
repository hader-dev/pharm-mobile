import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/sub_pages/order_items/widgets/order_items_section.dart';

class OrderDetailsItemsSection extends StatelessWidget {
  const OrderDetailsItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(builder: (context, state) {
      final cubit = context.read<OrderDetailsCubit>();

      if (state is OrderDetailsLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      final isEmpty = cubit.orderData?.orderItems.isEmpty ?? true;
      if (state is OrderDetailsLoadingFailed || isEmpty) {
        return Center(child: const EmptyListWidget());
      }
      return OrderItemsSection(orderItems: cubit.orderData!.orderItems);
    });
  }
}
