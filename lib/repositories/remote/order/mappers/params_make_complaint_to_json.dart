import 'package:hader_pharm_mobile/repositories/remote/order/params/item_complaint.dart';

Map<String, dynamic> paramsMakeComplaintToJson(ParamsMakeComplaint params) {
  return {
    "orderId": params.orderId,
    "itemId": params.itemId,
    "subject": params.subject,
    "descirption": params.description
  };
}
