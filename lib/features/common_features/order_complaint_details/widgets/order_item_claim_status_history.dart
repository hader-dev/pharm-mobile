import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/cubit/orders_complaint_details_cubit.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'tracking_status_step_widget.dart';

class OrderItemClaimStatusHistory extends StatelessWidget {
  const OrderItemClaimStatusHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomSheetHeader(title: context.translation!.order_tracking),
        const ResponsiveGap.s12(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: context
              .read<OrderComplaintsCubit>()
              .state
              .complaintStatusHitsory
              .length,
          itemBuilder: (BuildContext context, int index) {
            final ClaimStatusHistoryModel step = context
                .read<OrderComplaintsCubit>()
                .state
                .complaintStatusHitsory[index];
            final bool isFirst = index == 0;
            final bool isLast = index ==
                context
                        .read<OrderComplaintsCubit>()
                        .state
                        .complaintStatusHitsory
                        .length -
                    1;
            return TrackingClaimStepWidget(
              historyStep: step,
              isFirst: isFirst,
              isLast: isLast,
            );
          },
        ),
      ],
    );
  }
}
