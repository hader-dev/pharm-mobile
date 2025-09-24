import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/models/order.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';

import '../../../../../utils/constants.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final IOrderRepository orderRepository;
  final ScrollController scrollController;
  OrdersCubit({required this.orderRepository, required this.scrollController})
      : super(OrdersInitial()) {
    _onScroll();
  }
  Future<void> getOrders({
    int offset = 0,
  }) async {
    emit(state.loading(offset: offset));
    var ordersResponse = await orderRepository.getOrders(
      offset: offset,
      sortDirection: 'DESC',
    );
    emit(state.loaded(
        orders: ordersResponse.data, totalItemsCount: state.totalItemsCount));
  }

  Future<void> loadMoreOrders() async {
    try {
      if (state.offSet >= state.totalItemsCount) {
        emit(state.loadLimitReached());
        return;
      }

      final offSet = state.offSet + PaginationConstants.resultsPerPage;
      emit(state.loading(offset: offSet));
      var ordersResponse = await orderRepository.getOrders(
        offset: offSet,
      );
      emit(state.loaded(
          orders: ordersResponse.data,
          totalItemsCount: ordersResponse.totalItems));
    } catch (e) {
      emit(state.loadingFailed());
    }
  }

  _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (state.offSet < state.totalItemsCount) {
          await loadMoreOrders();
        } else {
          emit(state.loadLimitReached());
        }
      }
    });
  }
}
