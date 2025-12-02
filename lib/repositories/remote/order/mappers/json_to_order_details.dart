import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/mappers/json_to_order_item.dart';

OrderDetailsModel jsonToOrderDetails(Map<String, dynamic> json) {
  final sellerCompany = jsonToCompany(json['sellerCompany']);
  final clientCompany = jsonToCompany(json['clientCompany']);

  return OrderDetailsModel(
    id: json['id'],
    discount: json['discount'] != null ? double.parse(json['discount']) : 0.0,
    invoiceType: json['invoiceType'],
    paymentMethod: json['paymentMethod'],
    displayId: json['displayId'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    deliveryAddress: json['deliveryAddress'] ?? '',
    status: json['status'] ?? 1,
    totalAmountExclTax: json['totalAmountHt'] != null ? double.parse(json['totalAmountHt']) : 0.0,
    totalAppliedAmount: json['totalAppliedAmount'] != null ? double.parse(json['totalAppliedAmount']) : 0.0,
    totalAmountInclTax: json['totalAmountTtc'] != null ? double.parse(json['totalAmountTtc']) : 0.0,
    latitude: json['latitude'] != null ? double.parse(json['latitude']) : 0.0,
    longitude: json['longitude'] != null ? double.parse(json['longitude']) : 0.0,
    clientCompanyId: sellerCompany.id,
    sellerCompanyId: sellerCompany.id,
    delegateUserId: json['delegateUserId'],
    operatorUserId: json['operatorUserId'],
    stockUserId: json['stockUserId'],
    deliveryTownId: json['deliveryTownId'],
    clientNote: json['clientNote'] ?? "",
    privateNote: json['privateNote'] ?? "",
    totalAppliedAmountHt: json['totalAppliedAmountHt'] != null ? double.parse(json['totalAppliedAmountHt']) : 0.0,
    totalAppliedAmountTtc: json['totalAppliedAmountTtc'] != null ? double.parse(json['totalAppliedAmountTtc']) : 0.0,
    orderItems: jsonToOrderItemModelList(json['orderItems']),
    orderStatusHistories: jsonToOrderStatusHistoryList(json['orderStatusHistories']),
    clientCompany: clientCompany,
    sellerCompany: sellerCompany,
  );
}
