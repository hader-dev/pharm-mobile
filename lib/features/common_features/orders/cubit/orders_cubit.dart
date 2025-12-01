import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/models/order.dart';
import 'package:hader_pharm_mobile/models/order_filters.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/get_orders.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../../config/routes/routing_manager.dart' show RoutingManager;
import '../orders.dart' show OrdersScreenState;

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final IOrderRepository orderRepository;
  final TextEditingController searchController;
  Timer? _debounce;

  OrdersCubit({
    required this.searchController,
    required this.orderRepository,
  }) : super(OrdersInitial()) {
    state.scrollController.addListener(() {
      if (state.scrollController.position.maxScrollExtent >=
          MediaQuery.sizeOf(RoutingManager.rootNavigatorKey.currentContext!).height * .9) {
        if (state.scrollController.position.pixels > 5 &&
            state.scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          OrdersScreenState.animationController.forward();
        }
        if (state.scrollController.position.pixels > 5 &&
            state.scrollController.position.userScrollDirection == ScrollDirection.forward) {
          OrdersScreenState.animationController.reverse();
        }
      }
      if (state.scrollController.position.pixels >= state.scrollController.position.maxScrollExtent) {
        loadMoreOrders();
      }
    });
  }

  Future<void> getOrders({
    int offset = 0,
    OrderFilters? filters,
  }) async {
    emit(state.toLoading(offset: offset));
    var ordersResponse = await orderRepository.getOrders(
      ParamsGetOrder(
          offset: offset,
          sortDirection: 'DESC',
          searchQuery: searchController.text.trim(),
          filters: filters ?? state.filters),
    );

    emit(state.toLoaded(orders: ordersResponse.data, totalItemsCount: ordersResponse.totalItems));
  }

  Future<void> loadMoreOrders() async {
    try {
      if (state.offSet >= state.totalItemsCount) {
        emit(state.toLoadLimitReached());
        return;
      }

      final offSet = state.offSet + PaginationConstants.resultsPerPage;

      emit(state.toLoadingMore(offSet));
      var ordersResponse = await orderRepository.getOrders(ParamsGetOrder(
        offset: offSet,
        sortDirection: 'DESC',
        limit: PaginationConstants.resultsPerPage,
        filters: state.filters,
        searchQuery: searchController.text.trim(),
      ));
      final updated = state.orders.toList();
      updated.addAll(ordersResponse.data);
      emit(state.toLoaded(orders: updated, totalItemsCount: ordersResponse.totalItems));
    } catch (e) {
      emit(state.toLoadingFailed());
    }
  }

  Future<void> _debounceFunction(Future<void> Function() func, [int milliseconds = 500]) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
      _debounce = null;
    });
  }

  void searchOrders([String? searchValue]) => _debounceFunction(() => getOrders());

  void resetOrderFilters() {
    getOrders(filters: OrderFilters());

    emit(state.toSearchFilterChanged(
      filters: OrderFilters(),
    ));
  }

  void updatedFilters(OrderFilters appliedFilters) {
    emit(state.toSearchFilterChanged(
      filters: appliedFilters,
    ));
  }

  @override
  Future<void> close() {
    state.scrollController.dispose();
    return super.close();
  }
}
