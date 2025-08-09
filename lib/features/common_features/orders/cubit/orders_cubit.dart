import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'package:hader_pharm_mobile/models/order.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';

import '../../../../../utils/constants.dart';
import '../../../../utils/enums.dart' show OrderClaimStatus;

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  int totalItemsCount = 0;
  int offSet = 0;
  List<BaseOrderModel> orders = [];
  List<int> selectedStatusFilters = [];
  double? minPriceFilter = 0.0;
  double? maxPriceFilter = 0;
  String? initialDateFilter;
  String? finalDateFilter;
  final IOrderRepository orderRepository;
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
        sortDirection: 'DESC',
        finalDateFilter: finalDateFilter,
        initialDateFilter: initialDateFilter,
        maxPriceFilter: maxPriceFilter,
        minPriceFilter: minPriceFilter,
        statusesFilter: selectedStatusFilters,
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
        finalDateFilter: finalDateFilter,
        initialDateFilter: initialDateFilter,
        maxPriceFilter: maxPriceFilter,
        minPriceFilter: minPriceFilter,
        statusesFilter: selectedStatusFilters,
      );
      totalItemsCount = medicinesResponse.totalItems;
      orders.addAll(medicinesResponse.data);
      emit(OrdersLoaded());
    } catch (e) {
      offSet = offSet - PaginationConstants.resultsPerPage;
      emit(OrdersLoadingFailed());
    }
  }

  void updateStatusFilter(int statusId) {
    if (statusId == -1) {
      if (selectedStatusFilters.length == OrderClaimStatus.values.length) {
        selectedStatusFilters = [];
      } else {
        selectedStatusFilters = OrderClaimStatus.values.map((e) => e.id).toList();
      }
      emit(StatusFilterChanged());
      return;
    }
    if (selectedStatusFilters.contains(statusId)) {
      selectedStatusFilters.remove(statusId);
    } else {
      selectedStatusFilters.add(statusId);
    }
    emit(StatusFilterChanged());
  }

  void updatePriceFilter({
    double? minPrice,
    double? maxPrice,
  }) {
    if (minPrice != null) {
      minPriceFilter = minPrice;
    }
    if (maxPrice != null) {
      maxPriceFilter = maxPrice;
    }

    emit(PriceFilterChanged());
  }

  void updateDateFilter({String? initialDate, String? finalDate, bool removeValue = false}) {
    if (removeValue) {
      if (initialDate != null) {
        initialDateFilter = null;
      }
      if (finalDate != null) {
        finalDateFilter = null;
      }
    } else {
      if (initialDate != null) {
        initialDateFilter = initialDate;
      }
      if (finalDate != null) {
        finalDateFilter = finalDate;
      }
    }

    emit(DateFilterChanged());
  }

  void resetFilters() {
    selectedStatusFilters = [];
    minPriceFilter = null;
    maxPriceFilter = null;
    initialDateFilter = null;
    finalDateFilter = null;
    emit(ResetFilters());
  }

  void applyFilters() {
    offSet = 0;
    getOrders();
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
