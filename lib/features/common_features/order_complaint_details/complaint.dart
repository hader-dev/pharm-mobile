import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/cubit/orders_complaint_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/views/complaint_view.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/widgets/order_item_claim_appbar.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class OrderItemComplaintScreen extends StatelessWidget {
  const OrderItemComplaintScreen({super.key, required this.orderId, required this.itemId, required this.complaintId});

  final String orderId;
  final String itemId;
  final String complaintId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrderItemComplaintAppBar(),
      body: BlocProvider(
        create: (context) => OrderComplaintsCubit(
          orderId: orderId,
          itemId: itemId,
          complaintId: complaintId,
          orderRepository: OrderRepository(
            client: getItInstance.get<INetworkService>(),
          ),
        )..getItemComplaint(),
        child: Padding(
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
          child: OrderComplaintContent(
            orderId: orderId,
            itemId: itemId,
            complaintId: complaintId,
          ),
        ),
      ),
    );
  }
}
