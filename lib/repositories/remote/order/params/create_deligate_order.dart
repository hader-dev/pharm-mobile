import 'package:hader_pharm_mobile/models/deligate_order.dart';

class ParamsCreateDeligateOrder {
  final String deliveryAddress;
  final int deliveryTownId;
  final List<DeligateParahparmOrderItem> orderItems;
  final String clientId;
  final String clientCompanyId;
  final String? clientNote;

  ParamsCreateDeligateOrder(
      {required this.deliveryAddress,
      this.clientNote,
      required this.deliveryTownId,
      required this.orderItems,
      required this.clientId,
      required this.clientCompanyId});
}
