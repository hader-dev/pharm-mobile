import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';

import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';

import 'package:iconsax/iconsax.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/bottom_sheet_helper.dart' show BottomSheetHelper;
import '../../../utils/constants.dart';
import '../../common/app_bars/custom_app_bar.dart';
import '../../common/widgets/end_of_load_result_widget.dart';
import 'cubit/orders_cubit.dart';
import 'widget/order_card.dart';
import 'widget/search_filter_bottom_sheet/search_filter_bottom_sheet.dart' show OrdersFilterBottomSheet;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider.value(
      value: AppLayout.appLayoutScaffoldKey.currentContext!.read<OrdersCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(
          bgColor: AppColors.bgWhite,
          topPadding: MediaQuery.of(context).padding.top,
          bottomPadding: MediaQuery.of(context).padding.bottom,
          leading: IconButton(
            icon: const Icon(
              Iconsax.box,
              size: AppSizesManager.iconSize25,
            ),
            onPressed: () {},
          ),
          title: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              return RichText(
                text: TextSpan(
                  text: "Orders",
                  style: AppTypography.headLine3SemiBoldStyle.copyWith(color: TextColors.primary.color),
                  children: [
                    TextSpan(
                        text: " (${BlocProvider.of<OrdersCubit>(context).orders.length})",
                        style: AppTypography.bodySmallStyle.copyWith(color: TextColors.ternary.color)),
                  ],
                ),
              );
            },
          ),
          trailing: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p12),
                child: BlocBuilder<OrdersCubit, OrdersState>(
                  builder: (context, state) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          Iconsax.filter,
                          color: AppColors.accent1Shade1,
                        ),
                        // if (BlocProvider.of<OrdersCubit>(context).selectedMedicineSearchFilter != null)
                        if (context.read<OrdersCubit>().selectedStatusFilters.isNotEmpty ||
                            context.read<OrdersCubit>().minPriceFilter != null ||
                            context.read<OrdersCubit>().maxPriceFilter != null ||
                            context.read<OrdersCubit>().initialDateFilter != null ||
                            context.read<OrdersCubit>().finalDateFilter != null)
                          Positioned(
                            top: -4,
                            right: -4,
                            child: CircleAvatar(
                              radius: AppSizesManager.commonWidgetsRadius,
                              backgroundColor: Colors.red,
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
              onTap: () {
                BottomSheetHelper.showCommonBottomSheet(context: context, child: OrdersFilterBottomSheet());
              },
            ),
            // IconButton(
            //   icon: const Icon(Iconsax.search_normal),
            //   onPressed: () {},
            // ),
            // IconButton(
            //   icon: const Icon(Iconsax.notification),
            //   onPressed: () {},
            // ),
          ],
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is OrdersLoaded && BlocProvider.of<OrdersCubit>(context).orders.isEmpty) {
              return ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.maxFinite),
                  child: EmptyListWidget(
                    onRefresh: () {
                      BlocProvider.of<OrdersCubit>(context).getOrders();
                    },
                  ));
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return BlocProvider.of<OrdersCubit>(context).getOrders();
                    },
                    child: ListView.builder(
                        controller: BlocProvider.of<OrdersCubit>(context).scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: BlocProvider.of<OrdersCubit>(context).orders.length,
                        itemBuilder: (context, index) => OrderCard(
                              orderData: BlocProvider.of<OrdersCubit>(context).orders[index],
                            )),
                  ),
                ),
                if (state is LoadingMoreOrders) const Center(child: CircularProgressIndicator()),
                if (state is OrdersLoadLimitReached) EndOfLoadResultWidget(),
              ],
            );
          },
        ),
      ),
    ));
  }
}
