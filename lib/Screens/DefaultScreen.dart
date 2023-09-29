import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ippu/Screens/CommunicationScreen.dart';
import 'package:ippu/Screens/CpdsScreen.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/Screens/HomeScreen.dart';
import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ippu/models/UserData.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
 
class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  late List<ProfileData> profileDataList = [];
  void initState() {
  super.initState();
  fetchProfileData(); // Call the function to fetch profile data
}
  int _selectedIndex = 0;
  List Page = [
 HomeScreen(),
 CpdsScreen(),
 EventsScreen(),
 CommunicationScreen(),

   ];
    void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
 
            UserData userData = UserData(
            id: profileData.data['id'],
            name: profileData.data['name'],
            email: profileData.data['email'],
            gender: profileData.data['gender'].toString(),
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
      Provider.of<UserProvider>(context, listen: false).setProfileStatus(profileData.data['gender'].toString());

    }
    // 
      final status  =    Provider.of<UserProvider>(context, listen: false).getSubscriptionStatus;
      final userdata = Provider.of<UserProvider>(context).user;
      Provider.of<UserProvider>(context).setProfileStatus('${userdata!.gender}');
    // 
    print("===================================");
    final size =MediaQuery.of(context).size;
    return Scaffold(
      body: Page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
       backgroundColor: Color.fromARGB(255, 42, 129, 201).withOpacity(0.9),
        currentIndex: _selectedIndex,
        onTap: ((value) => onItemTapped(value)),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 169, 230, 216).withOpacity(0.5),
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.workspace_premium), label: 'CPD'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Communication'),
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
}
class ProfileData {
  final Map<String, dynamic> data;

  ProfileData({required this.data});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(data: json['data']);
  }
}