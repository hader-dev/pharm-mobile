List<T> mapJsonDynamicListToTypedList<T>(List<dynamic>? value) {
  if (value == null) return [];
  return value.whereType<T>().toList();
}
