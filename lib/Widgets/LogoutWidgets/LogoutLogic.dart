import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// Future<void> performLogout(  {required String token}) async {
//   // final logoutUrl = Uri.parse('http://app.ippu.or.ug/api/logout');
//   // final headers = {
//   //   'Authorization': 'Bearer $token',
//   // };

//   // final response = await http.post(logoutUrl, headers: headers);
//   final userData = Provider.of<UserProvider>(context, listen: false).user;

//   // Define the URL with userData.id
//   final apiUrl = 'http://app.ippu.or.ug/api/education-background/${userData?.id}';

//   // Define the headers with the bearer token
//   final headers = {
//     'Authorization': 'Bearer ${userData?.token}',
//   };
//   if (response.statusCode == 204) {
//     // Logout was successful
//     print('Logged out successfully');

//   } else {
//     // Logout failed, handle errors
//     print('Logout failed: ${response.body}');
//   }
// }
