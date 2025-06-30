import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/services/network/network_interface.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/constants.dart';
import '../../common/app_bars/custom_app_bar.dart';
import '../../common/widgets/end_of_load_result_widget.dart';
import 'cubit/orders_cubit.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          title: const Text(
            "Orders",
            style: AppTypography.headLine3SemiBoldStyle,
          ),
          // trailing: [
          //   // IconButton(
          //   //   icon: const Icon(Iconsax.search_normal),
          //   //   onPressed: () {},
          //   // ),
          //   // IconButton(
          //   //   icon: const Icon(Iconsax.notification),
          //   //   onPressed: () {},
          //   // ),
          // ],
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocProvider(
                create: (context) => OrdersCubit(
                    scrollController: ScrollController(),
                    orderRepository: OrderRepository(client: getItInstance.get<INetworkService>()))
                  ..getOrders(),
                child: Material(child: BlocBuilder<OrdersCubit, OrdersState>(
                  builder: (context, state) {
                    if (state is OrdersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is OrdersLoaded && BlocProvider.of<OrdersCubit>(context).orders.isEmpty) {
                      return EmptyListWidget();
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
                                itemBuilder: (context, index) => Container()
                                //  MedicineWidget2(
                                //   medicineData: BlocProvider.of<MedicineProductsCubit>(context).medicines[index],
                                // ),
                                ),
                          ),
                        ),
                        if (state is LoadingMoreOrders) const Center(child: CircularProgressIndicator()),
                        if (state is OrdersLoadLimitReached) EndOfLoadResultWidget(),
                      ],
                    );
                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
