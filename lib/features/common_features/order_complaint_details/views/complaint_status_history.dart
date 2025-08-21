import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/cubit/orders_complaint_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/widgets/tracking_status_step_widget.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class ComplaintStatusHistory extends StatelessWidget {
  const ComplaintStatusHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderComplaintsCubit>();
    final translation = context.translation!;

    if (cubit.complaintStatusHitsory.isEmpty) {
      return const Center(
        child: EmptyListWidget(),
      );
    }

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Text(
          translation.claim_status_history,
          style: context.responsiveTextTheme.current.headLine3SemiBold
              .copyWith(color: AppColors.accent1Shade1),
        ),
        ...cubit.complaintStatusHitsory.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isFirst = index == 0;
          final isLast = index == cubit.complaintStatusHitsory.length - 1;

          return TrackingClaimStepWidget(
            historyStep: step,
            isFirst: isFirst,
            isLast: isLast,
          );
        }),
      ],
    );
  }
}
