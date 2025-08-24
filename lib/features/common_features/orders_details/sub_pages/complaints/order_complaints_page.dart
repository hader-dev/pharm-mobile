import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/sub_pages/complaints/widgets/order_complaint_header_widget.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class OrderItemsComplaintPage extends StatelessWidget {
  const OrderItemsComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderDetailsCubit>();
    final scrollContoller = ScrollController();

    return BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
        builder: (context, state) {
      if (state is OrderDetailsLoading) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      }

      if (state is OrderDetailsLoadingFailed) {
        return const EmptyListWidget();
      }

      if (cubit.orderClaims.isEmpty) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: EmptyListWidget(),
            ),
          ],
        );
      }

      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizesManager.p12,
          horizontal: AppSizesManager.p6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              context.translation!.order_complaint,
              style: context.responsiveTextTheme.current.headLine4SemiBold,
            ),
            const SizedBox(height: 12),
            Container(
              constraints:  BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child: Scrollbar(
                controller: scrollContoller,
                child: Padding(
                  padding: const EdgeInsets.only(right: AppSizesManager.p8),
                  child: Material(
                    child: ListView(
                      controller: scrollContoller,
                      shrinkWrap: true,
                      children: cubit.orderClaims
                          .map(
                            (OrderClaimHeaderModel item) =>
                                OrderComplaintHeaderWidget(
                              claim: item,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
