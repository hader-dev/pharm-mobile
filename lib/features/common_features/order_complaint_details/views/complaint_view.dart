import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/cubit/orders_complaint_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/views/complaint_review.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/views/make_complaint_view.dart';

class OrderComplaintContent extends StatelessWidget {
  const OrderComplaintContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderComplaintsCubit, OrdersComplaintState>(
        builder: (context, state) {
      final cubit = context.read<OrderComplaintsCubit>();

      if (state is OrderComplaintsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is OrderComplaintsLoadingFailed) {
        return MakeComplaintView();
      }

      if (cubit.claimData != null) {
        return ComplaintReviewView();
      }

      return MakeComplaintView();
    });
  }
}
