
import 'package:flutter/material.dart';

class ProfilePicProvider extends ChangeNotifier {
  late String _profilePic;
  String get profilePic => _profilePic;

  void setProfilePic(String profilePic) {
    _profilePic = profilePic;
    notifyListeners();
    print("profile pic set for all screens");
  }
}