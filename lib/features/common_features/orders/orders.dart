import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common/widgets/end_of_load_result_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/orders/orders_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/widget/filters_bar.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/filters_repository.dart';

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
          value: AppLayout.appLayoutScaffoldKey.currentContext!
              .read<OrdersCubit>(),
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
                      return const Center(child: CircularProgressIndicator());
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
                      onRefresh: () {
                        return cubit.getOrders(
                          filters: state.filters,
                        );
                      },
                      child: ListView.builder(
                        controller: cubit.scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.orders.length + 1,
                        itemBuilder: (context, index) {
                          if (index < state.orders.length) {
                            return OrderCard(orderData: state.orders[index]);
                          } else {
                            if (state is LoadingMoreOrders) {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            } else if (state is OrdersLoadLimitReached) {
                              return const EndOfLoadResultWidget();
                            } else {
                              return const SizedBox.shrink();
                            }
                          }
                        },
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
