//import '../../../model/person.dart';

import '../../../models/payment_method.dart';

abstract class IPaymentMethodRepository {
  Future<List<PaymentMethod>> getPaymentMethods();
}
