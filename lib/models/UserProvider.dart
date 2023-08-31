import 'package:flutter/material.dart';
import 'package:ippu/models/UserData.dart';

class UserProvider extends ChangeNotifier {
  UserData? _user;

  UserData? get user => _user;

  void setUser(UserData userData) {
    _user = userData;
    notifyListeners();
  }
}
