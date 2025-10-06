import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/actions/can_cancel_order.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/widgets/cancel_order_bottom_sheet.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/widgets/order_client_note.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/widgets/order_invoice_section.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/widgets/order_summary_section.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/widgets/shipping_address_section.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/widgets/track_order_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class OrdersDetailsPage extends StatelessWidget {
  final String orderId;
  static final GlobalKey<ScaffoldState> ordersDetailsScaffoldKey =
      GlobalKey<ScaffoldState>();
  const OrdersDetailsPage({super.key, required this.orderId});
  final bool isInvoiceWorkInProgress = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonsPadding = const EdgeInsets.only(
        left: AppSizesManager.p6,
        right: AppSizesManager.p6,
        bottom: AppSizesManager.p6);
    final translation = context.translation!;

    return RefreshIndicator(
      onRefresh: () => context.read<OrderDetailsCubit>().reloadOrderData(),
      child: BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
        builder: (context, state) {
          if (state is OrderDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is OrderDetailsLoadingFailed) {
            return Center(child: const EmptyListWidget());
          }
          final cubit = context.read<OrderDetailsCubit>();

          final item = cubit.orderData!;

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ShippingAddressSection(
                  address: item.deliveryAddress,
                  latitude: cubit.orderData!.latitude,
                  longitude: cubit.orderData!.longitude,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: AppSizesManager.p4),
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizesManager.p4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        AppSizesManager.commonWidgetsRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (cubit.orderData!.invoiceType != null)
                        OrderInvoiceSection(
                          invoiceType: InvoiceTypes.values.firstWhere(
                              (element) =>
                                  cubit.orderData!.invoiceType == element.id),
                        ),
                      if (cubit.orderData!.clientNote.isNotEmpty)
                        ClientNoteSection(),
                      const OrderSummarySection(),
                      Padding(
                        padding: buttonsPadding,
                        child: PrimaryTextButton(
                          label: translation.order_tracking,
                          onTap: () {
                            BottomSheetHelper.showCommonBottomSheet(
                                context: context,
                                child: OrderTrackingBottomSheet());
                          },
                          color: AppColors.accent1Shade1,
                        ),
                      ),
                      if (!isInvoiceWorkInProgress)
                        Padding(
                          padding: buttonsPadding,
                          child: PrimaryTextButton(
                            label: translation.invoice,
                            onTap: () {
                              RoutingManager.router.pushNamed(
                                  RoutingManager.invoiceScreen,
                                  extra: orderId);
                            },
                            color: AppColors.accent1Shade1,
                          ),
                        ),
                      if (canCancelOrderByStatusId(item.status))
                        Padding(
                          padding: buttonsPadding,
                          child: PrimaryTextButton(
                            label: translation.cancel,
                            onTap: () {
                              BottomSheetHelper.showCommonBottomSheet(
                                  initialChildSize: 0.3,
                                  context: context,
                                  child: CancelOrderBottomSheet());
                            },
                            color: theme.colorScheme.error,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
