import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<void> performLogout(  {required String token}) async {
  final logoutUrl = Uri.parse('http://app.ippu.or.ug/api/logout');
  final headers = {
    'Authorization': 'Bearer $token',
  };

  final response = await http.post(logoutUrl, headers: headers);

  if (response.statusCode == 204) {
    // Logout was successful
    print('Logged out successfully');

  } else {
    // Logout failed, handle errors
    print('Logout failed: ${response.body}');
  }
}
