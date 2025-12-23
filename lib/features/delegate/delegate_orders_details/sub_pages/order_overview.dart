import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart' show RoutingManager;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart' show AppColors, SystemColors;
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart' show AppDivider;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart' show ResponsiveGap;

import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/actions/can_cancel_order.dart'
    show canCancelOrderByStatusId;
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/cubit/order_details/orders_details_cubit.dart'
    show OrderDetailsLoading, DelegateOrdersDetails2State, OrderDetailsLoadingFailed, DelegateOrderDetails2Cubit;
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/sub_pages/order_items/order_items.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/widgets/cancel_order_bottom_sheet.dart'
    show DelegateCancelOrderBottomSheet;
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/widgets/order_client_note.dart'
    show DelegateClientNoteSection;
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/widgets/order_infos_section.dart'
    show DelegateOrderInfosSection;
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/widgets/order_invoice_section.dart'
    show DelegateOrderInvoiceSection;
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/widgets/order_summary_section.dart'
    show DelegateOrderSummarySection;
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/widgets/shipping_address_section.dart'
    show DelegateShippingAddressSection;

import 'package:hader_pharm_mobile/utils/enums.dart' show OrderStatus, InvoiceTypes;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';

import '../../../../utils/bottom_sheet_helper.dart' show BottomSheetHelper;
import '../../../common/buttons/solid/primary_text_button.dart' show PrimaryTextButton;
import '../../../common/chips/custom_chip.dart' show CustomChip;
import '../../../common/widgets/empty_list.dart' show EmptyListWidget;

class DelegateOrdersOverViewPage extends StatelessWidget {
  final String orderId;
  const DelegateOrdersOverViewPage({super.key, required this.orderId});
  final bool isInvoiceWorkInProgress = true;

  @override
  Widget build(BuildContext context) {
    final buttonsPadding = EdgeInsets.only(
        left: context.responsiveAppSizeTheme.current.p6,
        right: context.responsiveAppSizeTheme.current.p6,
        bottom: context.responsiveAppSizeTheme.current.p6);
    final translation = context.translation!;

    return RefreshIndicator(
      onRefresh: () => context.read<DelegateOrderDetails2Cubit>().reloadOrderData(),
      child: BlocBuilder<DelegateOrderDetails2Cubit, DelegateOrdersDetails2State>(
        builder: (context, state) {
          if (state is OrderDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is OrderDetailsLoadingFailed) {
            return Center(child: const EmptyListWidget());
          }
          final cubit = context.read<DelegateOrderDetails2Cubit>();
          final item = cubit.state.orderData;
          final orderStatus =
              OrderStatus.values.firstWhere((OrderStatus element) => element.id == cubit.state.orderData.status);

          return Scrollbar(
            child: SingleChildScrollView(
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
                  DelegateOrderInfosSection(
                    orderRef: cubit.state.orderData.displayId,
                    createdAt: cubit.state.orderData.createdAt.format,
                  ),
                  AppDivider(
                    height: context.responsiveAppSizeTheme.current.p12,
                    color: Colors.grey.shade100,
                    endIndent: context.responsiveAppSizeTheme.current.s8,
                    indent: context.responsiveAppSizeTheme.current.s8,
                  ),
                  DelegateShippingAddressSection(
                    address: cubit.state.orderData.deliveryAddress,
                    latitude: cubit.state.orderData.latitude,
                    longitude: cubit.state.orderData.longitude,
                  ),
                  AppDivider(
                    height: context.responsiveAppSizeTheme.current.p12,
                    color: Colors.grey.shade100,
                    endIndent: context.responsiveAppSizeTheme.current.s8,
                    indent: context.responsiveAppSizeTheme.current.s8,
                  ),
                  if (cubit.state.orderData.invoiceType != null)
                    DelegateOrderInvoiceSection(
                      invoiceType:
                          InvoiceTypes.values.firstWhere((element) => cubit.state.orderData.invoiceType == element.id),
                    ),
                  if (cubit.state.orderData.clientNote.isNotEmpty) ...[
                    AppDivider(
                      height: context.responsiveAppSizeTheme.current.p12,
                      color: Colors.grey.shade100,
                      endIndent: context.responsiveAppSizeTheme.current.s8,
                      indent: context.responsiveAppSizeTheme.current.s8,
                    ),
                    DelegateClientNoteSection()
                  ],
                  AppDivider(
                    height: context.responsiveAppSizeTheme.current.p12,
                    color: Colors.grey.shade100,
                    endIndent: context.responsiveAppSizeTheme.current.s8,
                    indent: context.responsiveAppSizeTheme.current.s8,
                  ),
                  DelegateOrderDetailsItemsSection(),
                  AppDivider(
                    height: context.responsiveAppSizeTheme.current.p12,
                    color: Colors.grey.shade100,
                    endIndent: context.responsiveAppSizeTheme.current.s8,
                    indent: context.responsiveAppSizeTheme.current.s8,
                  ),
                  const DelegateOrderSummarySection(),
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
                                    initialChildSize: 0.5, context: context, child: DelegateCancelOrderBottomSheet());
                              },
                              color: Colors.transparent,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
