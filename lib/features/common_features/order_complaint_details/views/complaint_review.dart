import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart' show AppDivider;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/info_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/cubit/orders_complaint_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/order_complaint_details/views/complaint_status_history.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';

class ComplaintReviewView extends StatelessWidget {
  const ComplaintReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<OrderComplaintsCubit>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ResponsiveGap.s12(),
          InfoWidget(
            label: translation.order_complaint,
            value: Text(
              "# ${cubit.state.claimData.displayId}",
              style: context.responsiveTextTheme.current.body3Medium,
            ),
          ),
          Row(
            children: [
              Flexible(
                child: InfoWidget(
                    label: translation.created,
                    value: Text(
                      cubit.state.claimData.createdAt.format,
                      style: context.responsiveTextTheme.current.body3Medium,
                    )),
              ),
              ResponsiveGap.s8(),
              Flexible(
                child: InfoWidget(
                  label: translation.last_update,
                  value: Text(
                    cubit.state.claimData.createdAt.format,
                    style: context.responsiveTextTheme.current.body3Medium,
                  ),
                ),
              ),
            ],
          ),
          InfoWidget(
            label: translation.subject,
            value: Text(
              cubit.state.claimData.subject,
              style: context.responsiveTextTheme.current.body3Medium,
            ),
          ),
          InfoWidget(
            label: translation.description,
            value: Text(
              cubit.state.claimData.description,
              style: context.responsiveTextTheme.current.body3Medium,
            ),
          ),
          AppDivider(
            height: context.responsiveAppSizeTheme.current.p12,
            color: Colors.grey.shade100,
            endIndent: context.responsiveAppSizeTheme.current.s8,
            indent: context.responsiveAppSizeTheme.current.s8,
          ),
          ComplaintStatusHistory(),
        ],
      ),
    );
  }
}
