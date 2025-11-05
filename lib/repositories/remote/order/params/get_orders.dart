import 'package:hader_pharm_mobile/models/order_filters.dart';

class ParamsGetOrder {
  final String? searchQuery;
  final int limit;
  final int offset;
  final String sortDirection;
  final OrderFilters filters;

  ParamsGetOrder(
      {this.searchQuery,
      this.limit = 8,
      this.offset = 0,
      this.filters = const OrderFilters(),
      this.sortDirection = 'DESC'});
}
