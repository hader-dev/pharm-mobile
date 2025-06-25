class Urls {
  //users endpoint
  static String get users => "/users";

  //Auth endpoint

  static String get auth => "/auth";
  static String get refreshToken => "$auth/refresh-token";

  static String get logIn => "$auth/log-in";
  static String get signUp => "$auth/sign-up";
  static String get verifyEmail => "$auth/verify-email";
  static String get resendOtp => "$auth/resend-email-otp";
  static String get forgotPassword => "$auth/forgot-password";

  static String get me => "$users/me";

  //Client
  static String get client => "/clients";

  //Company
  static String get company => "/companies";

  //Medicines
  static String get medicinesCatalog => "/medicines-catalog";

  //Medicine parapharm-catalog
  static String get paraPharamaCatalog => "/parapharm-catalog";

  //Orders
  static String get orders => "/orders";

  //Cart Items
  static String get cartItems => "/cart-items";

  static String get cartItemsBulkRemove => "$cartItems/bulk-remove";

  //get Remote Stored Images
  //static String get images => "$schema$domainName/uploads";

  //api error mapping key
  static const String apiErrorKey = 'message';
  static const String apiErrorCodeKey = 'statusCode';
}
