import 'package:hader_pharm_mobile/utils/enums.dart';

class CreateOrderModel {
  String? clientNote;
  String deliveryAddress;
  PaymentMethods paymentMethod;
  InvoiceTypes invoiceType;
  int deliveryTownId;
  List<String> cartItemsIds;
  String sellerCompanyId;
  double? latitude;
  double? longitude;

  CreateOrderModel(
      {required this.sellerCompanyId,
      required this.deliveryAddress,
      required this.deliveryTownId,
      this.paymentMethod = PaymentMethods.cash,
      this.invoiceType = InvoiceTypes.facture,
      this.cartItemsIds = const [],
      this.clientNote,
      this.latitude,
      this.longitude});
  Map<String, dynamic> toJson() {
    return {
      "sellerCompanyId": sellerCompanyId,
      if (clientNote != null && clientNote!.isNotEmpty)
        'clientNote': clientNote,
      'deliveryAddress': deliveryAddress,
      'deliveryTownId': deliveryTownId,
      if (cartItemsIds.isNotEmpty) 'cartItemsIds': cartItemsIds,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      'paymentMethodId': paymentMethod.id,
      'invoiceTypeId': invoiceType.id
    };
  }
}
