import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/orders/orders_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/orders.dart';

class OrderFilterProvider extends StatelessWidget {
  const OrderFilterProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final orderCubit =
        AppLayout.appLayoutScaffoldKey.currentContext!.read<OrdersCubit>();

    final filterCubit =
        OrdersScreen.scaffoldKey.currentContext!.read<OrdersFiltersCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: orderCubit,
        ),
        BlocProvider.value(
          value: filterCubit,
        ),
        // BlocProvider(
        //   create: (_) => OrdersFiltersCubit(
        //     filtersRepository: getItInstance.get<IFiltersRepository>(),
        //   ),
        // ),
      ],
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return child;
        },
      ),
    );
  }
}
