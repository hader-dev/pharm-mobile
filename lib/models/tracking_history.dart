class OrderHistory {
  final int status;
  final DateTime createdAt;

  OrderHistory({
    required this.status,
    required this.createdAt,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      status: json['statusId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
