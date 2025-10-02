class ParamsGetOrder {
  final String? searchQuery;
  final int limit;
  final int offset;
  final String sortDirection;

  ParamsGetOrder(
      {this.searchQuery,
      this.limit = 8,
      this.offset = 0,
      this.sortDirection = 'DESC'});
}
