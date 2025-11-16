import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart' show AppDivider;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/actions/can_cancel_order.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/sub_pages/order_items/order_items.dart'
    show OrderDetailsItemsSection;
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/cancel_order_bottom_sheet.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/order_client_note.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/order_infos_section.dart'
    show OrderInfosSection;
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/order_invoice_section.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/order_summary_section.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/shipping_address_section.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/track_order_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';

import '../../../common/chips/custom_chip.dart' show CustomChip;

class OrdersDetailsPage extends StatelessWidget {
  final String orderId;
  static final GlobalKey<ScaffoldState> ordersDetailsScaffoldKey = GlobalKey<ScaffoldState>();
  const OrdersDetailsPage({super.key, required this.orderId});
  final bool isInvoiceWorkInProgress = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonsPadding = EdgeInsets.only(
        left: context.responsiveAppSizeTheme.current.p6,
        right: context.responsiveAppSizeTheme.current.p6,
        bottom: context.responsiveAppSizeTheme.current.p6);
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
          final orderStatus =
              OrderStatus.values.firstWhere((OrderStatus element) => element.id == cubit.orderData!.status);

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: context.responsiveAppSizeTheme.current.p8,
                    vertical: context.responsiveAppSizeTheme.current.p4,
                  ),
                  child: Row(children: <Widget>[
                    Spacer(),
                    CustomChip(
                        label: OrderStatus.getTranslatedStatus(orderStatus),
                        labelColor: orderStatus.color,
                        labelStyle: context.responsiveTextTheme.current.bodyXSmall.copyWith(
                            fontWeight: context.responsiveTextTheme.current.appFont.appFontBold,
                            color: orderStatus.color),
                        color: orderStatus.color.withAlpha(50))
                  ]),
                ),
                OrderInfosSection(
                  orderRef: cubit.orderData!.displayId,
                  createdAt: cubit.orderData!.createdAt.format,
                ),
                AppDivider(
                  height: context.responsiveAppSizeTheme.current.p12,
                  color: Colors.grey.shade100,
                  endIndent: context.responsiveAppSizeTheme.current.s8,
                  indent: context.responsiveAppSizeTheme.current.s8,
                ),
                ShippingAddressSection(
                  address: cubit.orderData!.deliveryAddress,
                  latitude: cubit.orderData!.latitude,
                  longitude: cubit.orderData!.longitude,
                ),
                AppDivider(
                  height: context.responsiveAppSizeTheme.current.p12,
                  color: Colors.grey.shade100,
                  endIndent: context.responsiveAppSizeTheme.current.s8,
                  indent: context.responsiveAppSizeTheme.current.s8,
                ),
                if (cubit.orderData!.invoiceType != null)
                  OrderInvoiceSection(
                    invoiceType:
                        InvoiceTypes.values.firstWhere((element) => cubit.orderData!.invoiceType == element.id),
                  ),
                if (cubit.orderData!.clientNote.isNotEmpty) ...[
                  AppDivider(
                    height: context.responsiveAppSizeTheme.current.p12,
                    color: Colors.grey.shade100,
                    endIndent: context.responsiveAppSizeTheme.current.s8,
                    indent: context.responsiveAppSizeTheme.current.s8,
                  ),
                  ClientNoteSection()
                ],
                AppDivider(
                  height: context.responsiveAppSizeTheme.current.p12,
                  color: Colors.grey.shade100,
                  endIndent: context.responsiveAppSizeTheme.current.s8,
                  indent: context.responsiveAppSizeTheme.current.s8,
                ),
                ConstrainedBox(constraints: BoxConstraints(maxHeight: 300), child: OrderDetailsItemsSection()),
                AppDivider(
                  height: context.responsiveAppSizeTheme.current.p12,
                  color: Colors.grey.shade100,
                  endIndent: context.responsiveAppSizeTheme.current.s8,
                  indent: context.responsiveAppSizeTheme.current.s8,
                ),
                const OrderSummarySection(),
                ResponsiveGap.s16(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p4),
                  padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (!isInvoiceWorkInProgress)
                        Padding(
                          padding: buttonsPadding,
                          child: PrimaryTextButton(
                            label: translation.invoice,
                            onTap: () {
                              RoutingManager.router.pushNamed(RoutingManager.invoiceScreen, extra: orderId);
                            },
                            color: AppColors.accent1Shade1,
                          ),
                        ),
                      if (canCancelOrderByStatusId(item.status))
                        Padding(
                          padding: buttonsPadding,
                          child: PrimaryTextButton(
                            label: translation.cancel,
                            labelColor: SystemColors.red.primary,
                            isOutLined: true,
                            borderColor: SystemColors.red.primary,
                            onTap: () {
                              BottomSheetHelper.showCommonBottomSheet(
                                  initialChildSize: 0.3, context: context, child: CancelOrderBottomSheet());
                            },
                            color: Colors.transparent,
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
