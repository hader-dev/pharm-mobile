import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/widgets/order_item_widget.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class DeligateOrderItemsPage extends StatelessWidget {
  const DeligateOrderItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizesManager.p8),
      child: BlocBuilder<DeligateCreateOrderCubit, DeligateCreateOrderState>(
        builder: (context, state) {
          final items = state.orderProducts;

          return items.isEmpty
              ? const Center(
                  child: EmptyListWidget(),
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => DeligateOrderItemWidget(
                    item: items[index],
                  ),
                );
        },
      ),
    );
  }
}
