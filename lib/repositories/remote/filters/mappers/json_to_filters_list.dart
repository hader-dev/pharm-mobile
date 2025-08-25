List<String> jsonToFilterList(String filterKey, Map<String, dynamic> json) {
  final data = json['data'];

  if (data is List) {
    return data
        .whereType<Map<String, dynamic>>()
        .map((el) => el[filterKey]?.toString() ?? '')
        .where((val) => val.isNotEmpty)
        .toList();
  }

  return [];
}
