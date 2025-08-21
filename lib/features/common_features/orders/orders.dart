import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import 'cubit/orders_cubit.dart';
import 'widget/order_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider.value(
      value: AppLayout.appLayoutScaffoldKey.currentContext!.read<OrdersCubit>(),
      child: Scaffold(
        appBar: CustomAppBarV2.alternate(
          topPadding: MediaQuery.of(context).padding.top,
          bottomPadding: MediaQuery.of(context).padding.bottom,
          leading: IconButton(
            icon: const Icon(
              Iconsax.box,
              color: AppColors.bgWhite,
              size: AppSizesManager.iconSize25,
            ),
            onPressed: () {},
          ),
          title: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              return RichText(
                text: TextSpan(
                  text: context.translation!.orders,
                  style: context.responsiveTextTheme.current.headLine3SemiBold
                      .copyWith(color: AppColors.bgWhite),
                  children: [
                    TextSpan(
                        text:
                            " (${BlocProvider.of<OrdersCubit>(context).orders.length})",
                        style: context.responsiveTextTheme.current.bodySmall
                            .copyWith(
                                color: AppColors.accent1Shade2Deemphasized)),
                  ],
                ),
              );
            },
          ),
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is OrdersLoaded &&
                BlocProvider.of<OrdersCubit>(context).orders.isEmpty) {
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
                        controller: BlocProvider.of<OrdersCubit>(context)
                            .scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount:
                            BlocProvider.of<OrdersCubit>(context).orders.length,
                        itemBuilder: (context, index) => OrderCard(
                              orderData: BlocProvider.of<OrdersCubit>(context)
                                  .orders[index],
                            )),
                  ),
                ),
                if (state is LoadingMoreOrders)
                  const Center(child: CircularProgressIndicator()),
                if (state is OrdersLoadLimitReached) EndOfLoadResultWidget(),
              ],
            );
          },
        ),
      ),
    ));
  }
}
