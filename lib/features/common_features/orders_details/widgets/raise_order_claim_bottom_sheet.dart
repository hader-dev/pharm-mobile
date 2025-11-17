import 'package:flutter/material.dart';

import '../../order_complaint_details/views/complaint_view.dart' show OrderComplaintContent;

class RaiseOrderClaimBottomSheet extends StatelessWidget {
  final String orderId;

  const RaiseOrderClaimBottomSheet({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return OrderComplaintContent(
      orderId: orderId,
      complaintId: '',
      itemId: '',
    );
  }
}
