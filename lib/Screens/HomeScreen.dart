import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:ippu/Providers/ProfilePicProvider.dart';
import 'package:ippu/Screens/ProfileScreen.dart';
import 'package:ippu/Screens/SettingsScreen.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/FirstDisplaySection.dart';
import 'package:ippu/models/UserData.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
  }

  Future<bool> checkProfileStatus(UserData user) async {
    if (user.gender == null &&
        user.dob == null &&
        user.membership_number == null &&
        user.address == null &&
        user.phone_no == null &&
        user.nok_name == null &&
        user.nok_phone_no == null) {
      print("gender: ${user.gender}");
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        width: size.width * 0.8,
        child: const DrawerWidget(),
      ),
      appBar: AppBar(
        // leading: Icon(Icons.menu),
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SettingsScreen();
              }));
            },
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfileScreen();
                }));
              },
              child: Padding(
                padding: EdgeInsets.only(right: size.width * 0.06),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      context.watch<ProfilePicProvider>().profilePic),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          )
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          FirstDisplaySection(),
        ],
      ),
    );
  }

  void showBottomNotification(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }
  //
}

class ProfileData {
  final Map<String, dynamic> data;

  ProfileData({required this.data});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(data: json['data']);
  }
}
