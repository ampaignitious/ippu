// api_constants.dart
 


class AppEndpoints {
  static const String baseUrl = "https://ippu.org/api";
  static const String loginEndPoint = "/login";
  static const String regiserEndPoint = "/register";
  static const String logoutEndPoint = "/logout";


  static const String cpdsEndPoint = "/cpds";
  static const String eventsEndPoint = "/events";
  static const String educationBackgroundEndPoint = "/education-background";
  static const String upcomingCpdsEndPoint = "/upcoming-cpds";
  static const String upcomingEventsEndPoint = "/upcoming-events";
  static const String myEventsEndPoint ="/attended-events/";
  static const String accountTypesEndPoint = "/account-types";
  static const String allCommunications ="/communications";



  static const int timeout =
      30; // Increase or decrease as per your requirement.
  static String refreshToken = 'refresh_token';
  static String keyForJWTToken = 'accessToken';
}


