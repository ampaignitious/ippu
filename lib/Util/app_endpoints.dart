// api_constants.dart
 

import 'package:flutter/src/widgets/framework.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';


class AppEndpoints {
  static const String baseUrl = "http://app.ippu.or.ug/api";
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


