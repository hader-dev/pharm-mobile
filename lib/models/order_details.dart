// import 'order.dart';
// import 'order_Item.dart';
// import 'tracking_history.dart' show OrderHistory;

// class OrderDetailsModel extends Order {
//   final List<OrderItem> orderItems;
//   final List<OrderHistory> orderHistory;

//   OrderDetailsModel({
//     required super.orderId,
//     super.note,
//     required super.discount,
//     required super.discountPercentage,
//     required super.clientFirstName,
//     required super.clientLastName,
//     required super.deliveryAddress,
//     required super.clientMobile,
//     required super.clientFax,
//     required super.clientPhone,
//     required super.stampDuty,
//     required super.amountHt,
//     required super.netAmountTtc,
//     required super.netToPay,
//     required super.totalTva,
//     required super.ref,
//     required super.createdAt,
//     required super.updatedAt,
//     required super.clientId,
//     required super.paymentMethodId,
//     required super.status,
//     required super.latitude,
//     required super.longitude,
//     this.orderItems = const <OrderItem>[],
//     this.orderHistory = const <OrderHistory>[],
//   });

//   factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
//     return OrderDetailsModel(
//       orderId: json['id'],
//       note: json['note'],
//       discount: double.parse(json['discount']),
//       discountPercentage: json['discountPercentage'],
//       clientFirstName: json['clientFirstName'],
//       clientLastName: json['clientLastName'],
//       deliveryAddress: json['deliveryAddress'],
//       clientMobile: json['clientMobile'],
//       clientFax: json['clientFax'],
//       clientPhone: json['clientPhone'],
//       stampDuty: double.parse(json['stampDuty']),
//       amountHt: double.parse(json['amountHt']),
//       netAmountTtc: double.parse(json['netAmountTtc']),
//       netToPay: double.parse(json['netToPay']),
//       totalTva: double.parse(json['totalTva']),
//       ref: json['ref'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       clientId: json['clientId'],
//       paymentMethodId: json['paymentMethodId'],
//       status: json['statusId'],
//       latitude: double.parse(json['latitude'] ?? "0.0"),
//       longitude: double.parse(json['longitude'] ?? "0.0"),
//       orderItems: (json['orderItems'] as List).map((item) => OrderItem.fromJson(item)).toList(),
//       orderHistory: (json['history'] as List).map((item) => OrderHistory.fromJson(item)).toList(),
//     );
//   }
// }
