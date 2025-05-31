class PaymentMethod {
  final int id;
  final String label;
  final bool isStamp;
  late String iconPath;

  PaymentMethod({required this.id, required this.label, required this.isStamp});

  // Factory constructor to create a PaymentMethod from JSON
  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      label: json['label'],
      isStamp: json['isStamp'],
    );
  }
}
