import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_create_order/widgets/order_item_widget.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_marketplace/sub_pages/items_page/items_summary.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class DeligateOrderItemsPage extends StatelessWidget {
  const DeligateOrderItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
      child: BlocBuilder<DelegateCreateOrderCubit, DelegateCreateOrderState>(
        builder: (context, state) {
          final items = state.orderProducts;

          return Column(
            children: [
              Expanded(
                child: items.isEmpty
                    ? const Center(
                        child: EmptyListWidget(),
                      )
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) => DeligateOrderItemWidget(
                          item: items[index],
                        ),
                      ),
              ),
              DeligateItemsSummarySection()
            ],
          );
        },
      ),
    );
  }
}
