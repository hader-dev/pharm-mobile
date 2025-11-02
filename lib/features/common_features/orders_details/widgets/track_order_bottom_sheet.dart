import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../models/order_details.dart';
import '../../../common/buttons/solid/primary_text_button.dart';
import '../../../common/widgets/bottom_sheet_header.dart';
import '../../market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import '../cubit/orders_details_cubit.dart';
import '../orders_details.dart';
import 'tracking_step_widget.dart';

class OrderTrackingBottomSheet extends StatelessWidget {
  const OrderTrackingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: OrdersDetailsScreen.ordersDetailsScaffoldKey.currentContext!
          .read<OrderDetailsCubit>(),
      child: BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
        builder: (context, state) {
          if (state is! MedicineSearchFilterChanged) {}
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BottomSheetHeader(title: context.translation!.order_tracking),
              const ResponsiveGap.s12(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: context
                    .read<OrderDetailsCubit>()
                    .orderData!
                    .orderStatusHistories
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  final OrderStatusHistory step = context
                      .read<OrderDetailsCubit>()
                      .orderData!
                      .orderStatusHistories[index];
                  final bool isFirst = index == 0;
                  final bool isLast = index ==
                      context
                              .read<OrderDetailsCubit>()
                              .orderData!
                              .orderStatusHistories
                              .length -
                          1;
                  return TrackingStepWidget(
                    historyStep: step,
                    isFirst: isFirst,
                    isLast: isLast,
                  );
                },
              ),
              Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
              const ResponsiveGap.s12(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveAppSizeTheme.current.p4),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryTextButton(
                        label: context.translation!.close,
                        onTap: () {
                          context.pop();
                        },
                        color: AppColors.accent1Shade1,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
