import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ippu/models/CpdModel.dart';
 

// class CpdProvider {
//   final String baseUrl = "http://app.ippu.or.ug/api/cpds";
//   final String token;

//   CpdProvider(this.token);

//   Future<List<CpdModel>> fetchCpds() async {
//     final response = await http.get(
//       Uri.parse(baseUrl),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body)['data'];
//       return data.map((cpdData) => CpdModel.fromJson(cpdData)).toList();
//     } else {
//       throw Exception('Failed to load CPDs');
//     }
//   }
// }
class CpdsProvider extends ChangeNotifier {
  CpdModel? _cpds;

  CpdModel? get cpds => _cpds;

  void setUser(CpdModel cpdData) {
    _cpds = cpdData;
    notifyListeners();
  }
}
