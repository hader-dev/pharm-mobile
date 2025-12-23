import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/sub_pages/order_items/widgets/order_items_section.dart'
    show DelegateOrderItemsSection;

import '../../cubit/order_details/orders_details_cubit.dart'
    show DelegateOrderDetails2Cubit, DelegateOrdersDetails2State, OrderDetailsLoading, OrderDetailsLoadingFailed;

class DelegateOrderDetailsItemsSection extends StatelessWidget {
  const DelegateOrderDetailsItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DelegateOrderDetails2Cubit, DelegateOrdersDetails2State>(builder: (context, state) {
      final cubit = context.read<DelegateOrderDetails2Cubit>();

      if (state is OrderDetailsLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      final isEmpty = state.orderData.orderItems.isEmpty;
      if (state is OrderDetailsLoadingFailed || isEmpty) {
        return Center(child: const EmptyListWidget());
      }
      return DelegateOrderItemsSection(orderItems: state.orderData.orderItems);
    });
  }
}
