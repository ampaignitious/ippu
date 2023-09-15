import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ippu/models/CpdModel.dart';
 
class CpdsProvider extends ChangeNotifier {
  CpdModel? _cpds;

  CpdModel? get cpds => _cpds;

  void setUser(CpdModel cpdData) {
    _cpds = cpdData;
    notifyListeners();
  }
}
