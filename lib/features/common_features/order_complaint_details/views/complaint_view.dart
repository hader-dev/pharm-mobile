import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart' show getItInstance;
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart' show INetworkService;
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/cubit/orders_complaint_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/views/complaint_review.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/views/make_complaint_view.dart';

import '../../../../repositories/remote/order/order_repository_impl.dart' show OrderRepository;

class OrderComplaintContent extends StatelessWidget {
  final String orderId;
  final String itemId;
  final String complaintId;
  const OrderComplaintContent({super.key, required this.orderId, required this.itemId, required this.complaintId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderComplaintsCubit(
        orderId: orderId,
        itemId: itemId,
        complaintId: complaintId,
        orderRepository: OrderRepository(
          client: getItInstance.get<INetworkService>(),
        ),
      )..getItemComplaint(),
      child: BlocBuilder<OrderComplaintsCubit, OrdersComplaintState>(builder: (context, state) {
        final cubit = context.read<OrderComplaintsCubit>();

        if (state is OrderComplaintsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is OrderComplaintsLoadingFailed) {
          return MakeComplaintView();
        }

        if (cubit.state.claimData.id.isNotEmpty) {
          return ComplaintReviewView();
        }

        return MakeComplaintView();
      }),
    );
  }
}
