import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'package:hader_pharm_mobile/models/order.dart';

import '../../../../../utils/constants.dart';
import '../../../../repositories/remote/order/order_repository_impl.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  int totalItemsCount = 0;
  int offSet = 0;
  List<OrderModel> orders = [];
  final OrderRepository orderRepository;
  final ScrollController scrollController;
  OrdersCubit({required this.orderRepository, required this.scrollController}) : super(OrdersInitial()) {
    _onScroll();
  }
  Future<void> getOrders({
    int offset = 0,
  }) async {
    try {
      emit(OrdersLoading());
      var ordersResponse = await orderRepository.getOrders(
        offset: offset,
      );
      totalItemsCount = ordersResponse.totalItems;
      orders = ordersResponse.data;
      emit(OrdersLoaded());
    } catch (e) {
      emit(OrdersLoadingFailed());
    }
  }

  Future<void> loadMoreOrders() async {
    try {
      if (offSet >= totalItemsCount) {
        emit(OrdersLoadLimitReached());
        return;
      }

      offSet = offSet + PaginationConstants.resultsPerPage;
      emit(LoadingMoreOrders());
      var medicinesResponse = await orderRepository.getOrders(
        offset: offSet,
      );
      totalItemsCount = medicinesResponse.totalItems;
      orders.addAll(medicinesResponse.data);
      emit(OrdersLoaded());
    } catch (e) {
      offSet = offSet - PaginationConstants.resultsPerPage;
      emit(OrdersLoadingFailed());
    }
  }

  _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        if (offSet < totalItemsCount) {
          await loadMoreOrders();
        } else {
          emit(OrdersLoadLimitReached());
        }
      }
    });
  }
}
