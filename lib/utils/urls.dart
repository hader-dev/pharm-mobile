class Urls {
  //users endpoint
  static String get users => "/users";

  //Auth endpoint

  static String get auth => "/auth";
  static String get refreshToken => "$auth/refresh-token";

  static String get logIn => "$auth/log-in";
  static String get signUp => "$auth/sign-up";

  static String get me => "$users/me";

  //Client
  static String get client => "/clients";

  //get Remote Stored Images
  //static String get images => "$schema$domainName/uploads";

  //api error mapping key
  static const String apiErrorKey = 'message';
  static const String apiErrorCodeKey = 'statusCode';
}
