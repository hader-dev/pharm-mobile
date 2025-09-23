class ParamsLoadMyClients {
  final int limit;
  final int offset;
  final String? searchQuery;

  ParamsLoadMyClients({
    this.searchQuery,
    this.limit = 20,
    this.offset = 0,
  });
}
