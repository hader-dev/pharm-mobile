import 'package:equatable/equatable.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

class OrderFilters extends Equatable {
  final List<String> createdAtTo;

  final List<String> status;
  final List<String> createdAtFrom;

  const OrderFilters({
    this.createdAtFrom = const [],
    this.createdAtTo = const [],
    this.status = const [],
  });

  OrderFilters copyWith({
    List<String>? status,
    List<String>? createdAtFrom,
    List<String>? createdAtTo,
  }) {
    return OrderFilters(
      status: status ?? this.status,
      createdAtFrom: createdAtFrom ?? this.createdAtFrom,
      createdAtTo: createdAtTo ?? this.createdAtTo,
    );
  }

  bool get isNotEmpty =>
      createdAtFrom.isNotEmpty || createdAtFrom.isNotEmpty || status.isNotEmpty;

  @override
  List<Object?> get props => [
        createdAtTo,
        status,
        createdAtFrom,
      ];

  OrderFilters updateSearchFilter(OrderFiltersKeys key, String text) {
    matchList(List<String> list) =>
        list.where((el) => el.contains(text)).toList();

    switch (key) {
      case OrderFiltersKeys.status:
        return copyWith(status: matchList(status));
      case OrderFiltersKeys.createdAtFrom:
        return copyWith(createdAtFrom: matchList(createdAtFrom));
      case OrderFiltersKeys.createdAtTo:
        return copyWith(createdAtTo: matchList(createdAtTo));
    }
  }

  List<String> getFilterBykey(OrderFiltersKeys currentkey) {
    switch (currentkey) {
      case OrderFiltersKeys.status:
        return status;
      case OrderFiltersKeys.createdAtFrom:
        return createdAtFrom;
      case OrderFiltersKeys.createdAtTo:
        return createdAtTo;
    }
  }

  OrderFilters updateFilterList(
      OrderFiltersKeys key, List<String> updatedFilters) {
    switch (key) {
      case OrderFiltersKeys.status:
        return copyWith(status: updatedFilters);
      case OrderFiltersKeys.createdAtFrom:
        return copyWith(createdAtFrom: updatedFilters);
      case OrderFiltersKeys.createdAtTo:
        return copyWith(createdAtTo: updatedFilters);
    }
  }
}

enum OrderFiltersKeys {
  createdAtFrom,
  createdAtTo,
  status,
}

final orderStatusFilters =
    OrderStatus.values.map((e) => e.name.toUpperCase()).toList();
