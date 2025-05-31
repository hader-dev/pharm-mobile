import 'package:http/src/response.dart';

import '../../../config/services/network/network_manager.dart';
import '../../../config/services/network/network_response_handler.dart';

import '../../../models/payment_method.dart';

import '../../../utils/urls.dart';
import 'payment_method_repository.dart';

class PaymentMethodRepository extends IPaymentMethodRepository {
  final NetworkManager client;

  PaymentMethodRepository({required this.client});

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async {
    Response response = await client.sendRequest(() => client.get(Urls.paymentMethod));
    var decodedResponse = ResponseHandler.processResponse(response);

    return (decodedResponse as List).map((item) => PaymentMethod.fromJson(item)).toList();
  }
}
