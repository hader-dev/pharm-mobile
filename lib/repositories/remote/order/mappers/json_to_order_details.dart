import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/mappers/json_to_order_item.dart';

OrderDetailsModel jsonToOrderDetails(Map<String, dynamic> json) {
  return OrderDetailsModel(
    id: json['id'],
    discount: json['discount'] != null ? double.parse(json['discount']) : 0.0,
    invoiceType: json['invoiceType'],
    paymentMethod: json['paymentMethod'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    deliveryAddress: json['deliveryAddress'],
    status: json['status'],
    totalAmountExclTax: json['totalAmountHt'] != null
        ? double.parse(json['totalAmountHt'])
        : 0.0,
    totalAmountInclTax: json['totalAmountTtc'] != null
        ? double.parse(json['totalAmountTtc'])
        : 0.0,
    latitude: json['latitude'] != null ? double.parse(json['latitude']) : 0.0,
    longitude:
        json['longitude'] != null ? double.parse(json['longitude']) : 0.0,
    clientCompanyId: json['clientCompanyId'],
    sellerCompanyId: json['sellerCompanyId'],
    delegateUserId: json['delegateUserId'],
    operatorUserId: json['operatorUserId'],
    stockUserId: json['stockUserId'],
    deliveryTownId: json['deliveryTownId'],
    clientNote: json['clientNote'] ?? "",
    privateNote: json['privateNote'] ?? "",
    orderItems: jsonToOrderItemModelList(json['orderItems']),
    orderStatusHistories:
        jsonToOrderStatusHistoryList(json['orderStatusHistories']),
    clientCompany: jsonToCompany(json['clientCompany']),
    sellerCompany: jsonToCompany(json['sellerCompany']),
  );
}
