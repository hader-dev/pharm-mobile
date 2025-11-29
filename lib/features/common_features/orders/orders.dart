import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/orders/orders_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/widget/filters_bar.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/filters_repository.dart';

import '../../common/shimmers/order_widget_shimmer.dart' show OrderWidgetShimmer;
import 'cubit/orders_cubit.dart';
import 'widget/order_card.dart';

class OrdersScreen extends StatelessWidget {
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: AppLayout.appLayoutScaffoldKey.currentContext!.read<OrdersCubit>(),
        ),
        BlocProvider(
          create: (_) => OrdersFiltersCubit(
            filtersRepository: getItInstance.get<IFiltersRepository>(),
          ),
        ),
      ],
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Column(
            children: [
              const FiltersBar(),
              Expanded(
                child: BlocBuilder<OrdersCubit, OrdersState>(
                  builder: (context, state) {
                    final cubit = context.read<OrdersCubit>();

                    if (state is OrdersLoading) {
                      return ListView(shrinkWrap: true, children: List.generate(4, (_) => OrderWidgetShimmer()));
                    }
                    if (state.orders.isEmpty) {
                      return EmptyListWidget(
                        onRefresh: () {
                          cubit.getOrders(
                            filters: state.filters,
                          );
                        },
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => cubit.getOrders(
                        filters: state.filters,
                      ),
                      child: Scrollbar(
                        controller: state.scrollController,
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: state.scrollController,
                          children: [
                            ...state.orders.map((order) => OrderCard(
                                  orderData: order,
                                )),
                            if (state is LoadingMoreOrders)
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child:
                                    Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator())),
                              ),
                            if (state is OrdersLoadLimitReached) const EndOfLoadResultWidget()
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
