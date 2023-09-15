 
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../Util/app_endpoints.dart';



part 'auth_rest.g.dart';

@RestApi(baseUrl: AppEndpoints.baseUrl)
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio, {String baseUrl}) = _AuthRestClient;

  @POST(AppEndpoints.loginEndPoint)
  Future<dynamic> signIn({@Body() required Map<String, String> body});

  @POST(AppEndpoints.regiserEndPoint)
  Future<dynamic> signUp({@Body() required Map<String, String> body});

  @POST(AppEndpoints.logoutEndPoint)
  Future<dynamic> signOut();

  @GET(AppEndpoints.accountTypesEndPoint)
  Future<dynamic> getAccountTypes();

  @POST(AppEndpoints.educationBackgroundEndPoint)
  Future<dynamic> getEducationBackground({@Body() required Map<String, String> body});
  
  @GET(AppEndpoints.educationBackgroundEndPoint)
  Future<dynamic> getEducationDetails();
  
  @GET(AppEndpoints.allCommunications)
  Future<dynamic>getAllCommunications();

  @GET(AppEndpoints.cpdsEndPoint)
  Future<dynamic> getCpds();

  @GET(AppEndpoints.eventsEndPoint)
  Future<dynamic> getEvents();

  // @GET(AppEndpoints.myEventsEndPoint)
  // Future<dynamic> myEvents();  

  @GET(AppEndpoints.upcomingCpdsEndPoint)
  Future<dynamic> getUpcomingCpds();

  @GET(AppEndpoints.upcomingEventsEndPoint)
  Future<dynamic> getUpcomingEvents();
  

  //logout
  // @POST("${AppEndpoints.logout}")
  // Future<dynamic> signOut(@Path("userId") String userId);


}
