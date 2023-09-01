import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../Util/app_endpoints.dart';



part 'auth_rest.g.dart';

@RestApi(baseUrl: AppEndpoints.baseUrl)
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio, {String baseUrl}) = _AuthRestClient;

  @POST(AppEndpoints.loginEndPoint)
  Future<dynamic> signIn({@Body() required Map<String, String> body});

  //logout
  // @POST("${AppEndpoints.logout}")
  // Future<dynamic> signOut(@Path("userId") String userId);


}
