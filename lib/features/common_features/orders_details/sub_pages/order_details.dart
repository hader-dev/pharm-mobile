import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show  BlocBuilder, ReadContext;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/cubit/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/cancel_order_bottom_sheet.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/order_client_note.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/order_invoice_section.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/order_summary_section.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/shipping_address_section.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/track_order_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';



class OrdersDetailsPage extends StatelessWidget {
  final String orderId;
  static final GlobalKey<ScaffoldState> ordersDetailsScaffoldKey = GlobalKey<ScaffoldState>();
  const OrdersDetailsPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
            builder: (context, state) {
              if (state is OrderDetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is OrderDetailsLoadingFailed) {
                return Text(context.translation!.feedback_network_fetch_error);
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: AppSizesManager.p6, right: AppSizesManager.p6, bottom: AppSizesManager.p6),
                              child: PrimaryTextButton(
                                label: context.translation!.cancel,
                                onTap: () {
                                  BottomSheetHelper.showCommonBottomSheet(
                                    initialChildSize: 0.3,
                                      context: context, child: CancelOrderBottomSheet());
                                },
                                color: theme.colorScheme.error,
                              ),
                            ),
                          ],
                        ),),
                  ],
                ),
              );
            },
    );
  }
}

