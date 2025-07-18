import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

import 'package:hader_pharm_mobile/utils/constants.dart';

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
      value: OrdersDetailsScreen.ordersDetailsScaffoldKey.currentContext!.read<OrderDetailsCubit>(),
      child: BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
        builder: (context, state) {
          if (state is! MedicineSearchFilterChanged) {}
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BottomSheetHeader(title: 'Order Tracking'),
              Gap(AppSizesManager.s12),
              ListView.builder(
                shrinkWrap: true,
                itemCount: context.read<OrderDetailsCubit>().orderData!.orderStatusHistories.length,
                itemBuilder: (BuildContext context, int index) {
                  final OrderStatusHistory step =
                      context.read<OrderDetailsCubit>().orderData!.orderStatusHistories[index];
                  final bool isFirst = index == 0;
                  final bool isLast =
                      index == context.read<OrderDetailsCubit>().orderData!.orderStatusHistories.length - 1;
                  return TrackingStepWidget(
                    historyStep: step,
                    isFirst: isFirst,
                    isLast: isLast,
                  );
                },
              ),
              Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
              Gap(AppSizesManager.s12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryTextButton(
                        label: "Close",
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
