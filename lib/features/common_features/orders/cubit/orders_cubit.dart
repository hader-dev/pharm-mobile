import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/models/order.dart';
import 'package:hader_pharm_mobile/models/order_filters.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/get_orders.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final IOrderRepository orderRepository;
  final ScrollController scrollController;
  final TextEditingController searchController;
  Timer? _debounce;

  OrdersCubit(
      {required this.searchController,
      required this.orderRepository,
      required this.scrollController})
      : super(OrdersInitial()) {
    _onScroll();
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
    emit(state.toLoaded(
        orders: ordersResponse.data,
        totalItemsCount: ordersResponse.totalItems));
  }

  Future<void> loadMoreOrders() async {
    try {
      if (state.offSet >= state.totalItemsCount) {
        emit(state.toLoadLimitReached());
        return;
      }

      final offSet = state.offSet + PaginationConstants.resultsPerPage;
      emit(state.toLoading(offset: offSet));
      var ordersResponse = await orderRepository.getOrders(ParamsGetOrder(
        offset: offSet,
        sortDirection: 'DESC',
        limit: PaginationConstants.resultsPerPage,
        searchQuery: searchController.text.trim(),
      ));
      emit(state.toLoaded(
          orders: ordersResponse.data,
          totalItemsCount: ordersResponse.totalItems));
    } catch (e) {
      emit(state.toLoadingFailed());
    }
  }

  void _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (state.offSet < state.totalItemsCount) {
          await loadMoreOrders();
        } else {
          emit(state.toLoadLimitReached());
        }
      }

      final currentOffset = scrollController.offset;
      final previousOffset = state.lastOffset;

      bool displayFilters = state.displayFilters;

      if (currentOffset > previousOffset && displayFilters) {
        displayFilters = false;
      } else if (currentOffset < previousOffset && !displayFilters) {
        displayFilters = true;
      }

      if (displayFilters != state.displayFilters) {
        emit(state.toScroll(
          displayFilters: displayFilters,
          offset: currentOffset as int,
        ));
      } else {
        emit(state.toScroll(
          displayFilters: state.displayFilters,
          offset: currentOffset as int,
        ));
      }
    });
  }

  Future<void> _debounceFunction(Future<void> Function() func,
      [int milliseconds = 500]) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
      _debounce = null;
    });
  }

  void searchOrders([String? searchValue]) =>
      _debounceFunction(() => getOrders());

  void resetOrderFilters() {
    emit(state.toSearchFilterChanged(
      filters: OrderFilters(),
    ));
  }

  void updatedFilters(OrderFilters appliedFilters) {
    emit(state.toSearchFilterChanged(
      filters: appliedFilters,
    ));
  }
}
