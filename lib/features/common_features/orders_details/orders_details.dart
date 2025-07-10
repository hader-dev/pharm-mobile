import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocBuilder, ReadContext;
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/services/network/network_interface.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../repositories/remote/order/order_repository_impl.dart';
import '../../../utils/bottom_sheet_helper.dart';
import '../../../utils/constants.dart';
import '../../common/app_bars/custom_app_bar.dart';
import '../../common/buttons/solid/primary_text_button.dart';
import 'cubit/orders_details_cubit.dart';
import 'widgets/order_client_note.dart';
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
          appBar: CustomAppBar(
            bgColor: AppColors.bgWhite,
            topPadding: MediaQuery.of(context).padding.top,
            bottomPadding: MediaQuery.of(context).padding.bottom,
            leading: IconButton(
              icon: const Icon(
                Iconsax.arrow_left_2,
                size: AppSizesManager.iconSize25,
              ),
              onPressed: () {
                context.pop();
              },
            ),
            title: Row(
              children: [
                const Icon(
                  Iconsax.box_2,
                  size: AppSizesManager.iconSize25,
                ),
                Gap(AppSizesManager.s12),
                const Text(
                  "Order Details",
                  style: AppTypography.headLine3SemiBoldStyle,
                ),
              ],
            ),
            trailing: [
              BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
                builder: (context, state) {
                  if (state is OrderDetailsLoading) {
                    return Container(
                        padding: EdgeInsets.all(AppSizesManager.p6),
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.1,
                        ));
                  }
                  OrderStatus orderStatus = OrderStatus.values
                      .firstWhere((statusItem) => statusItem.id == context.read<OrderDetailsCubit>().orderData!.status);
                  return Container(
                    margin: EdgeInsets.only(right: AppSizesManager.p12),
                    padding: EdgeInsets.all(AppSizesManager.p6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(AppSizesManager.r6),
                          topLeft: Radius.circular(AppSizesManager.r6)),
                      color: orderStatus.color.withAlpha(50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(orderStatus.name,
                            style: AppTypography.bodySmallStyle
                                .copyWith(color: orderStatus.color, fontWeight: AppTypography.appFontSemiBold)),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
          body: BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
            builder: (context, state) {
              if (state is OrderDetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is OrderDetailsLoadingFailed) {
                return Text("Error happend when feetch  ");
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // const OrderHeaderSection(),
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
                            OrderInvoiceSection(),
                            ClientNoteSection(),
                            const OrderSummarySection(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: AppSizesManager.p6, right: AppSizesManager.p6, bottom: AppSizesManager.p6),
                              child: PrimaryTextButton(
                                label: "Track Order",
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
