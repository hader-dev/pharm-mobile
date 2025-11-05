import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/order_filters.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/filters_repository.dart';

part 'orders_filters_state.dart';

class OrdersFiltersCubit extends Cubit<OrdersFiltersState> {
  // ignore: unused_field
  late final IFiltersRepository _filtersRepository;

  final searchController = TextEditingController();

  OrdersFiltersCubit({required IFiltersRepository filtersRepository})
      : super(OrderFiltersStateInitial(
            filtersSource: OrderFilters(status: orderStatusFilters))) {
    _filtersRepository = filtersRepository;
  }

  int get pageIndex => state.pageIndex;
  OrderFilters get filtersSource => state.filtersSource;
  OrderFilters get appliedFilters => state.appliedFilters;
  OrderFiltersKeys get currentkey => state.currentKey;

  void updateVisibleItems() {
    emit(state.updated());
  }

  List<String> getCurrentWorkSourceFilters() {
    return filtersSource.getFilterBykey(currentkey);
  }

  List<String> getCurrentWorkAppliedFilters() {
    return appliedFilters.getFilterBykey(currentkey);
  }

  void updatedAppliedFilters(String value, bool isSelected,
      [bool replaceAll = false]) {
    final vFilters = [...appliedFilters.getFilterBykey(currentkey)];

    if (replaceAll) {
      vFilters.clear();
      vFilters.add(value);
    } else {
      if (isSelected) {
        vFilters.add(value);
      } else {
        vFilters.remove(value);
      }
    }

    final updatedAppliedFilters =
        appliedFilters.updateFilterList(currentkey, vFilters);

    emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
  }

  void goToAllFilters() {
    emit(state.pageChanged(newPageIndex: 0));
  }

  void goToApplyFilters(OrderFiltersKeys key) {
    emit(state.copyWith(
      pageIndex: 1,
      currentKey: key,
    ));
  }

  void updateFilterKey(OrderFiltersKeys key) {
    emit(state.copyWith(currentKey: key));
  }

  void initializePriceFilter() {
    emit(state.updated());
  }

  void resetCurrentFilters() {
    final updatedAppliedFilters =
        appliedFilters.updateFilterList(currentkey, []);
    searchController.clear();
    emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
  }

  void resetAllFilters() {
    const newAppliedFilters = OrderFilters();
    searchController.clear();

    emit(state.updated(updatedAppliedFilters: newAppliedFilters));
  }

  void onSearchChanged(String searchText) {
    state.searchDebounceTimer?.cancel();

    if (searchController.text != searchText) {
      searchController.text = searchText;
    }

    final newTimer = Timer(const Duration(milliseconds: 500), () {});

    emit(state.copyWith(searchDebounceTimer: newTimer));
  }

  void clearSearch() {
    searchController.clear();
  }

  @override
  Future<void> close() {
    state.searchDebounceTimer?.cancel();
    return super.close();
  }
}
