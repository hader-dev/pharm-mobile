class Urls {
  // Notifications
  static String get notifications => "/notifications";
  static String get notificationsUnreadCount => "/notifications/count";
  static String get notificationMarkAllRead => "/notifications/mark-all-read";
  static String notificationMarkRead(String id) =>
      "/notifications/$id/mark-read";

  //users endpoint
  static String get users => "/users";
  static String get me => "$users/me";
  static String get uploadUserImage => "$users/upload-image";

  //Auth endpoint

  static String get auth => "/auth";
  static String get refreshToken => "$auth/refresh-token";
  static String get logIn => "$auth/log-in";
  static String get signUp => "$auth/sign-up";
  static String get verifyEmail => "$auth/verify-email";
  static String get resendOtp => "$auth/resend-email-otp";
  static String get forgotPassword => "$auth/forgot-password";
  static String get changePassword => "$auth/change-password";
  static String get resetPassword => "$auth/reset-password";

  //Client
  static String get client => "/clients";

  //Company
  static String get company => "/companies";

  //clients-companies
  static String get clientsCompanies => "/clients-companies";
  static String get clientsCompaniesJoin => "$clientsCompanies/requests/join";

  //Medicines
  static String get medicinesCatalog => "/medicines-catalog";

  //Medicine parapharm-catalog
  static String get paraPharamaCatalog => "/parapharm-catalog";

  //Orders
  static String get orders => "/orders";
  static String get buyNow => "$orders/buy-now";
  //parapharm-brands
  static String get parapharmBrands => "/parapharm-brands";

  //Cart Items
  static String get cartItems => "/cart-items";
  static String get cartItemsBulkRemove => "$cartItems/bulk-remove";
  static String get removeAllCartItems => "$cartItems/remove-all";

  //favorites
  static String get favorites => "/favorite-";

  //Medicines
  static String get medicinesCatalog1 => "/medications-catalog";
  static String get medicines => "/medicines";

  //Medicine parapharm-catalog
  static String get paraPharamaCatalog1 => "/parapharm-catalog";
  static String get parapharms => "/parapharm-categories";

  static String get favoritesLikeMedicineCatalog =>
      "$favorites$medicinesCatalog1";
  static String get favoritesUnlikeMedicineCatalog =>
      "$favorites$medicinesCatalog1/by-medicine-catalog-id";
  static String get favoritesLikeParaPharmaCatalog =>
      "$favorites$paraPharamaCatalog1";
  static String get favoritesUnLikeParaPharmaCatalog =>
      "$favorites$paraPharamaCatalog1/by-parapharm-catalog-id";
  static String get favoritesCompany => "${favorites}companies";

  static String get publicFiles => "/files";

  //Announcements
  static String get announcements => "/announcements";

  //Complaints
  static String itemComplaint(String id) => "/complaints/$id";
  static String get complaints => "/complaints";

  static String get registerUserDevice => "/firebase/register";
}
