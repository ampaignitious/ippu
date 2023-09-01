// api_constants.dart

class AppEndpoints {
  static const String baseUrl = "http://app.ippu.or.ug/api";
  static const String loginEndPoint = "/login";

  static const int timeout =
      30; // Increase or decrease as per your requirement.
  static String refreshToken = 'refresh_token';
  static String keyForJWTToken = 'accessToken';
}
