import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/sub_pages/complaints/widgets/order_complaint_header_widget.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'widgets/complaint_shimmer.dart' show ComplaintShimmer;

class OrderItemsComplaintPage extends StatelessWidget {
  const OrderItemsComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollContoller = ScrollController();
    final translation = context.translation!;

    return BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(builder: (context, state) {
      final cubit = context.read<OrderDetailsCubit>();

      if (state is OrderDetailsLoading) {
        return ListView(
            shrinkWrap: true,
            children: List.generate(
              15,
              (_) => ComplaintShimmer(),
            ));
      }

      if (cubit.orderClaims.isEmpty || state is OrderDetailsLoadingFailed) {
        return RefreshIndicator(
            onRefresh: () => cubit.getOrderComplaints(),
            child: Center(
              child: EmptyListWidget(
                onRefresh: () => cubit.getOrderComplaints(),
              ),
            ));
      }

      return RefreshIndicator(
        onRefresh: () async => cubit.getOrderComplaints(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p6),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollContoller,
            padding: EdgeInsets.symmetric(
              vertical: context.responsiveAppSizeTheme.current.p12,
              horizontal: context.responsiveAppSizeTheme.current.p6,
            ),
            children: [
              Text(
                translation.order_complaint,
                style: context.responsiveTextTheme.current.headLine4SemiBold,
              ),
              const ResponsiveGap.s12(),
              ...cubit.orderClaims.map(
                (OrderClaimHeaderModel item) => OrderComplaintHeaderWidget.orderComplaintWidget(
                  claim: item,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
