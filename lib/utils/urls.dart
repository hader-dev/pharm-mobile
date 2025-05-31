class Urls {
  //static String schema = 'https://';

  //person endpoint
  static String get person => "/persons";

  //Auth endpoint

  static String get auth => "/auth";

  static String get me => "$auth/me";

  //Client
  static String get client => "/clients";

  //get Remote Stored Images
  //static String get images => "$schema$domainName/uploads";

  // products
  static String get product => "/products";
  //orders
  static String get order => "/orders";
  //files
  static String get file => "/files/";
  //item cart
  static String get cartItem => "/cart-items";
  static String get cartItemBulkRemove => "/cart-items/bulk-remove";
  //payment Methods
  static String get paymentMethod => "/payment-methods";
  // categories
  static String get categories => "/categories";

  //brands
  static String get brands => "/brands";

  //api error mapping key
  static const String apiErrorKey = 'message';
  static const String apiErrorCodeKey = 'statusCode';
}
