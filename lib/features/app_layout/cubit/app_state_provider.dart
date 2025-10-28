import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/services/notification/notification_service_port.dart';
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_layout_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/cubit/notifications_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/cart_items/cart_items_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

class AppStateProvider extends StatelessWidget {
  final Widget child;
  const AppStateProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotificationsCubit(
            notificationService: getItInstance.get<INotificationService>(),
            scrollController: ScrollController(),
          )..getUnreadNotificationsCount(),
        ),
        BlocProvider(
          create: (context) => AppLayoutCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(
            shippingAddress: UserManager.instance.currentUser.address,
            cartItemRepository: CartItemRepository(
              client: getItInstance.get<INetworkService>(),
            ),
            scrollController: ScrollController(),
            ordersRepository: OrderRepository(
              client: getItInstance.get<INetworkService>(),
            ),
          )..getCartItem(),
        ),
        BlocProvider(
          create: (context) => OrdersCubit(
            searchController: TextEditingController(),
            scrollController: ScrollController(),
            orderRepository: OrderRepository(
              client: getItInstance.get<INetworkService>(),
            ),
          )..getOrders(),
        ),
      ],
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartItemAdded) {
            getItInstance.get<ToastManager>().showToast(
                type: ToastType.success,
                message: context.translation!.cart_item_added_successfully);
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return child;
          },
        ),
      ),
    );
  }
}

class AppStateDeligateProvider extends StatelessWidget {
  final Widget child;
  const AppStateDeligateProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => NotificationsCubit(
          notificationService: getItInstance.get<INotificationService>(),
          scrollController: ScrollController(),
        )..getUnreadNotificationsCount(),
      ),
      BlocProvider(
        create: (context) => AppLayoutCubit(),
      ),
      BlocProvider(
        create: (context) => OrdersCubit(
          searchController: TextEditingController(),
          scrollController: ScrollController(),
          orderRepository: OrderRepository(
            client: getItInstance.get<INetworkService>(),
          ),
        )..getOrders(),
      ),
    ], child: child);
  }
}
