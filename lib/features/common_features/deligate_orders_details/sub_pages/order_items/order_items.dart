import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/sub_pages/order_items/widgets/order_items_section.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class OrderDetailsItemsPage extends StatelessWidget {
  const OrderDetailsItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return RefreshIndicator(
      onRefresh: () => context.read<OrderDetailsCubit>().reloadOrderData(),
      child: BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
        builder: (context, state) {
          final cubit = context.read<OrderDetailsCubit>();

          if (state is OrderDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final isEmpty = cubit.state.orderItems.isEmpty;
          final bottomNavigationWidget = state.didChange
              ? Padding(
                  padding: const EdgeInsets.all(AppSizesManager.p8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryTextButton(
                        label: translation.cancel,
                        onTap: cubit.cancelUpdateOrder,
                        color: Colors.red,
                        labelColor: AppColors.bgWhite,
                      ),
                      PrimaryTextButton(
                        label: translation.confirm,
                        onTap: () => cubit.confirmUpdateOrder(translation),
                        color: AppColors.accent1Shade1,
                        labelColor: AppColors.bgWhite,
                      )
                    ],
                  ),
                )
              : null;

          if (state is OrderDetailsLoadingFailed || isEmpty) {
            return Scaffold(
              body: Center(
                child: const EmptyListWidget(),
              ),
              bottomNavigationBar: bottomNavigationWidget,
            );
          }

          return Scaffold(
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: OrderItemsSection(
                  orderItems: cubit.state.orderItems,
                  canEdit:
                      cubit.state.orderData.status == OrderStatus.created.id),
            ),
            bottomNavigationBar: bottomNavigationWidget,
          );
        },
      ),
    );
  }
}
