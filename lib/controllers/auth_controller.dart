import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'rest/auth_rest.dart';

class AuthController {
  static String ACCESS_TOKEN = "access_token";

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final dio = Dio();
    final client = AuthRestClient(dio);
    try {
      Map<String, String> user = {"email": email, "password": password};
      final response = await client.signIn(body: user);

      if (response.containsKey('authorization') &&
          response['authorization'].containsKey('token')) {
        final accessToken = response['authorization']['token'];
        // Save the access token for later use
        await saveAccessToken(accessToken);
        return response;
      } else {
        return {
          "error": "Invalid credentials",
          "status": "error",
        };
      } // Handle the case when the access token is not present in the response
    } catch (e) {
      return {
        "error": "Invalid credentials",
        "status": "error",
      };
    }
  }

  saveAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ACCESS_TOKEN, accessToken);
  }

  getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(ACCESS_TOKEN)) {
      return "";
    }
    return prefs.getString(ACCESS_TOKEN);
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    final dio = Dio();
    final client = AuthRestClient(dio);
    try {
      Map<String, String> user = {"email": email, "password": password};
      final response = await client.signUp(body: user);

      if (response.containsKey('authorization') &&
          response['authorization'].containsKey('token')) {
        final accessToken = response['authorization']['token'];
        // Save the access token for later use
        await saveAccessToken(accessToken);
        return response;
      } else {
        return {
          "error": "Invalid credentials",
          "status": "error",
        };
      } // Handle the case when the access token is not present in the response
    } catch (e) {
      return {
        "error": "Invalid credentials",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getAccountTypes() async {
    final dio = Dio();
    final client = AuthRestClient(dio);
    try {
      final response = await client.getAccountTypes();
      return response;
    } catch (e) {
      return {
        "error": "Failed to get account types",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getEducationBackground(
      String user_id, String points, String field) async {
    final dio = Dio();
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    final client = AuthRestClient(dio);
    Map<String, String> details = {
      "user_id": user_id,
      "points": points,
      "field": field
    };
    try {
      final response = await client.getEducationBackground(body: details);
      return response;
    } catch (e) {
      return {
        "error": "Failed to get education background",
        "status": "error",
      };
    }
  }

  Future<List<dynamic>> getCpds() async {
    final dio = Dio();
    final client = AuthRestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //'X-Requested-With': 'XMLHttpRequest'
    dio.options.headers['X-Requested-With'] = "XMLHttpRequest";
    //print what is being sent
    // dio.interceptors.add(LogInterceptor(responseBody: true));

    try {
      final response = await client.getCpds();
      return response['data'];
    } catch (e) {
      return [];
    }
  }

    Future<List<dynamic>> getAllCommunications() async {
    final dio = Dio();
    final client = AuthRestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //'X-Requested-With': 'XMLHttpRequest'
    dio.options.headers['X-Requested-With'] = "XMLHttpRequest";
    //print what is being sent
    // dio.interceptors.add(LogInterceptor(responseBody: true));

    try {
      final response = await client.getAllCommunications();
      return response['data'];
    } catch (e) {
      return [];
    }
  }
    Future<List<dynamic>> getEducationDetails() async {
    final dio = Dio();
    final client = AuthRestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //'X-Requested-With': 'XMLHttpRequest'
    dio.options.headers['X-Requested-With'] = "XMLHttpRequest";
    //print what is being sent
    // dio.interceptors.add(LogInterceptor(responseBody: true));

    try {
      final response = await client.getEducationDetails();
      return response['data'];
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> getEvents() async {
    final dio = Dio();
    final client = AuthRestClient(dio);
    print("Bearer ${await getAccessToken()}");
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    dio.options.headers['X-Requested-With'] = ['XMLHttpRequest'];
    try {
      final response = await client.getEvents();
      return response['data'];
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> getUpcomingCpds() async {
    final dio = Dio();
    final client = AuthRestClient(dio);
    print("Bearer ${await getAccessToken()}");
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    dio.options.headers['X-Requested-With'] = ['XMLHttpRequest'];
    try {
      final response = await client.getUpcomingCpds();
      return response['data'];
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> signOut() async {
    final dio = Dio();
    final client = AuthRestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.signOut();
      return response;
    } catch (e) {
      return {
        "error": "Failed to sign out",
        "status": "error",
      };
    }
  }
  
}

//usage
// AuthController authController = AuthController();
// authController.signIn(email, password);
// authController.signUp(email, password);
// authController.signOut();
// authController.getAccountTypes();
// authController.getEducationBackground(user_id, points, field);
// await authController.getCpds();
// authController.getEvents();
// authController.getUpcomingCpds();