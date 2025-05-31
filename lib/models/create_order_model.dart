import 'package:hader_pharm_mobile/models/create_cart_item.dart';

class CreateOrderModel {
  String? note;
  String deliveryAddress;
  int deliveryTownId;
  int paymentMethodId;
  List<int> cartItemsIds;
  List<CreateCartItemModel> orderItems;
  String clientFirstName;
  String clientLastName;
  String clientPhone;
  String clientMobile;
  String clientFax;
  String tradeName;

  double? latitude;
  double? longitude;
  CreateOrderModel(
      {this.note,
      required this.deliveryAddress,
      required this.deliveryTownId,
      required this.paymentMethodId,
      this.cartItemsIds = const [],
      required this.clientFirstName,
      required this.clientLastName,
      required this.clientPhone,
      required this.clientMobile,
      required this.clientFax,
      required this.tradeName,
      this.orderItems = const [],
      this.latitude,
      this.longitude});
  Map<String, dynamic> toJson() {
    return {
      if (note != null && note!.isNotEmpty) 'note': note,
      'deliveryAddress': deliveryAddress,
      'deliveryTownId': deliveryTownId,
      'paymentMethodId': paymentMethodId,
      'clientTradeName': tradeName,
      if (cartItemsIds.isNotEmpty) 'cartItemsIds': cartItemsIds,
      if (cartItemsIds.isNotEmpty) 'orderItems': orderItems,
      'clientFirstName': clientFirstName,
      'clientLastName': clientLastName,
      'clientPhone': clientPhone,
      'clientMobile': clientMobile,
      'clientFax': clientFax,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude
    };
  }
}
