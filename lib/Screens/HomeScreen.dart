import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ippu/models/AllEventsModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ippu/Screens/ProfileScreen.dart';
import 'package:ippu/Screens/SettingsScreen.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/FirstDisplaySection.dart';
import 'package:ippu/models/UserData.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 
class _HomeScreenState extends State<HomeScreen> {
 
late List<ProfileData> profileDataList = [];
void initState() {
  super.initState();
  fetchProfileData(); // Call the function to fetch profile data
}
Future<void> fetchProfileData() async {
  try {
    final userData = Provider.of<UserProvider>(context, listen: false).user;
    if (userData == null) {
      throw Exception('User data is null');
    }

    final String apiUrl = 'https://ippu.org/api/profile/${userData.id}';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${userData.token}',
      },
    );

    if (response.statusCode == 200) {
      ProfileData profileData = ProfileData.fromJson(json.decode(response.body));
      setState(() {
        profileDataList.add(profileData);
      });
    } else {
      throw Exception('Failed to load profile data');
    }
  } catch (error) {
    print('Error fetching profile data: $error');
  }
}
  Widget build(BuildContext context) {
    print("===================================");
    print(profileDataList.length);
        // setting userData
    for (var profileData in profileDataList) {
    final userInfo = Provider.of<UserProvider>(context, listen: false).user;
  print(profileData);
            UserData userData = UserData(
            id: profileData.data['id'],
            name: profileData.data['name'],
            email: profileData.data['email'],
            gender: profileData.data['gender'],
            dob: profileData.data['dob'],
            membership_number: profileData.data['membership_number'],
            address: profileData.data['address'],
            phone_no: profileData.data['phone_no'],
            alt_phone_no: profileData.data['alt_phone_no'],
            nok_name: profileData.data['nok_name'],
            nok_address: profileData.data['nok_address'],
            nok_phone_no: profileData.data['nok_phone_no'],
            points: profileData.data['points'] ,
            subscription_status: profileData.data['subscription_status'].toString(),
            // subscription_status2: profileData.data['subscription_status'],
            token: userInfo!.token,
          );
      Provider.of<UserProvider>(context, listen: false).setUser(userData);
      Provider.of<UserProvider>(context, listen: false).setSubscriptionStatus(profileData.data['subscription_status'].toString());
    }
    // 
        final status  =    Provider.of<UserProvider>(context, listen: false).getSubscriptionStatus;


      final userdata = Provider.of<UserProvider>(context).user;

      Provider.of<UserProvider>(context).setProfileStatus('${userdata!.gender}');

    // 
    print("===================================");
    final size = MediaQuery.of(context).size;
    return Scaffold(
            drawer:Drawer(
        width: size.width*0.8,
        child: DrawerWidget(),
      ),
      appBar: AppBar(
              // leading: Icon(Icons.menu),
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return SettingsScreen();
              }));
            },
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ProfileScreen();
                }));
              },
              child: Padding(
                padding: EdgeInsets.only(right: size.width*0.06),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/image9.png'),
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