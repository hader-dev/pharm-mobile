import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocBuilder, ReadContext;
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'cubit/orders_details_cubit.dart';
import 'widgets/order_client_note.dart';
import 'widgets/order_details_appbar.dart';
import 'widgets/order_invoice_section.dart';
import 'widgets/order_items_section.dart';
import 'widgets/order_summary_section.dart';
import 'widgets/shipping_address_section.dart';
import 'widgets/track_order_bottom_sheet.dart';


class OrdersDetailsScreen extends StatelessWidget {
  final String orderId;
  static final GlobalKey<ScaffoldState> ordersDetailsScaffoldKey = GlobalKey<ScaffoldState>();
  const OrdersDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (context) =>
          OrderDetailsCubit(orderRepository: OrderRepository(client: getItInstance.get<INetworkService>()))
            ..getOrdersDetails(orderId: orderId),
      child: Scaffold(
          key: ordersDetailsScaffoldKey,
          appBar: OrderDetailsAppbar(),
          body: BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
            builder: (context, state) {
              if (state is OrderDetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is OrderDetailsLoadingFailed) {
                return Text(context.translation!.errors_network_fetch_error);
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    OrderItemsSection(orderItems: context.read<OrderDetailsCubit>().orderData!.orderItems),
                    ShippingAddressSection(
                      address: context.read<OrderDetailsCubit>().orderData!.deliveryAddress,
                      latitude: context.read<OrderDetailsCubit>().orderData!.latitude,
                      longitude: context.read<OrderDetailsCubit>().orderData!.longitude,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: AppSizesManager.p4),
                        padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                        ),
                        child: Column(
                          children: <Widget>[
                            if (context.read<OrderDetailsCubit>().orderData!.invoiceType != null)
                              OrderInvoiceSection(
                                invoiceType: InvoiceTypes.values.firstWhere((element) =>
                                    context.read<OrderDetailsCubit>().orderData!.invoiceType == element.id),
                              ),
                            if (context.read<OrderDetailsCubit>().orderData!.clientNote.isNotEmpty) ClientNoteSection(),
                            const OrderSummarySection(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: AppSizesManager.p6, right: AppSizesManager.p6, bottom: AppSizesManager.p6),
                              child: PrimaryTextButton(
                                label: context.translation!.order_tracking,
                                onTap: () {
                                  BottomSheetHelper.showCommonBottomSheet(
                                      context: context, child: OrderTrackingBottomSheet());
                                },
                                color: AppColors.accent1Shade1,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              );
            },
          )),
    ));
  }
}

