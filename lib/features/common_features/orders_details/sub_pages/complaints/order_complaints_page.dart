import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/sub_pages/complaints/widgets/order_complaint_header_widget.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class OrderItemsComplaintPage extends StatelessWidget {
  const OrderItemsComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollContoller = ScrollController();
    final translation = context.translation!;

    return BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
        builder: (context, state) {
      final cubit = context.read<OrderDetailsCubit>();

      if (state is OrderDetailsLoading) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      }

      if (cubit.orderClaims.isEmpty || state is OrderDetailsLoadingFailed) {
        return RefreshIndicator(
          onRefresh: () => cubit.getOrderComplaints(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: EmptyListWidget(),
                ),
              ],
            ),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async => cubit.getOrderComplaints(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollContoller,
          padding: const EdgeInsets.symmetric(
            vertical: AppSizesManager.p12,
            horizontal: AppSizesManager.p6,
          ),
          children: [
            Text(
              translation.order_complaint,
              style: context.responsiveTextTheme.current.headLine4SemiBold,
            ),
            const SizedBox(height: 12),
            ...cubit.orderClaims.map(
              (OrderClaimHeaderModel item) => OrderComplaintHeaderWidget(
                claim: item,
              ),
            ),
          ],
        ),
      );
    });
  }
}
