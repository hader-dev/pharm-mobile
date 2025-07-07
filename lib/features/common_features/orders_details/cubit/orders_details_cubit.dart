import 'package:bloc/bloc.dart';

import '../../../../models/order_details.dart';
import '../../../../repositories/remote/order/order_repository_impl.dart';

part 'orders_details_state.dart';

class OrderDetailsCubit extends Cubit<OrdersDetailsState> {
  OrderDetailsModel? orderData;
  final OrderRepository orderRepository;

  OrderDetailsCubit({
    required this.orderRepository,
  }) : super(OrdersInitial());

  Future<void> getOrdersDetails({required String orderId}) async {
    try {
      emit(OrderDetailsLoading());
      orderData = await orderRepository.getMOrderById(orderId);

      emit(OrderDetailsLoaded());
    } catch (e) {
      emit(OrderDetailsLoadingFailed());
    }
  }
}
