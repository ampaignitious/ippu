import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ippu/Providers/ProfilePicProvider.dart';
import 'package:ippu/Providers/SubscriptionStatus.dart';
import 'package:ippu/Providers/network.dart';
import 'package:ippu/Screens/CommunicationScreen.dart';
import 'package:ippu/Screens/CpdsScreen.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/Screens/HomeScreen.dart';
import 'package:ippu/Screens/animated_text.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:ippu/models/UserData.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

import '../Widgets/AuthenticationWidgets/LoginScreen.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  late Future<dynamic> profileData;
  @override
  void initState() {
    super.initState();
    profileData = loadProfile();
    initConnectivityListener();
  }

  void initConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        // Update the network status in your provider
        Provider.of<CheckNetworkConnectivity>(context, listen: false)
            .setConnectionStatus(result != ConnectivityResult.none);
      });

      // If connectivity is restored, reload the profile
      if (result != ConnectivityResult.none) {
        reloadProfile();
      }
    });
  }

  Future<void> reloadProfile() async {
    setState(() {
      profileData = loadProfile();
    });
  }

  Future<dynamic> loadProfile() async {
    AuthController authController = AuthController();
    try {
      final response = await authController.getProfile();
      if (response.containsKey("error")) {
        //check if it the error key is unauthorized and redirect to login
        if (response['error'] == "Unauthorized") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }));

          return;
        } else {
          // Handle the case where the API did not return a user profile
          throw Exception(response['error']);
        }
      } else {
        if (response['data'] != null) {
          // Access the user object directly from the 'data' key
          Map<String, dynamic> userData = response['data'];

          UserData profile = UserData(
            id: userData['id'],
            name: userData['name'].toString(),
            email: userData['email'].toString(),
            gender: userData['gender'].toString(),
            dob: userData['dob'].toString(),
            membership_number: userData['membership_number'].toString(),
            address: userData['address'].toString(),
            phone_no: userData['phone_no'].toString(),
            alt_phone_no: userData['alt_phone_no'].toString(),
            nok_name: userData['nok_name'].toString(),
            nok_address: userData['nok_address'].toString(),
            nok_phone_no: userData['nok_phone_no'].toString(),
            points: userData['points'].toString(),
            subscription_status: userData['subscription_status'].toString(),
            profile_pic: userData['profile_pic'] ??
                "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png",
          );

          if (mounted) {
            Provider.of<UserProvider>(context, listen: false).setUser(profile);
            Provider.of<ProfilePicProvider>(context, listen: false)
                .setProfilePic(profile.profile_pic);
            Provider.of<SubscriptionStatusProvider>(context, listen: false)
                .setSubscriptionStatus(profile.subscription_status!);
            Provider.of<UserProvider>(context, listen: false)
                .setProfileStatus(profile.checkifAnyIsNull());
          }

          return profile;
        } else {
          // Handle the case where the 'data' field in the API response is null
          throw Exception("You currently have no data");
        }
      }
    } catch (error) {
      return null;
    }
  }

  int _selectedIndex = 0;
  List Page = [
    const HomeScreen(),
    const CpdsScreen(),
    const EventsScreen(),
    const CommunicationScreen(),
  ];
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final connectivity = Provider.of<CheckNetworkConnectivity>(context);
    return FutureBuilder(
      future: profileData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Page[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor:
                  Color.fromARGB(255, 42, 129, 201).withOpacity(0.9),
              currentIndex: _selectedIndex,
              onTap: (value) {
                if (value != 0) {
                  final profileStatus =
                      Provider.of<UserProvider>(context, listen: false)
                          .profileStatusCheck;
                  if (profileStatus == true) {
                    _showDialog();
                    return;
                  }
                }
                setState(() {
                  _selectedIndex = value;
                });
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor:
                  Color.fromARGB(255, 169, 230, 216).withOpacity(0.5),
              showUnselectedLabels: true,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.workspace_premium), label: 'CPD'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.event), label: 'Events'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.info), label: 'Communication'),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: AnimatedLoadingText(
                    loadingTexts: [
                      "Loading",
                      "Please wait...",
                    ],
                  ),
                ),
              );
        } else {
          // Check if there is no internet connection
          if (!connectivity.isConnected) {
            showBottomNotification("No internet connection");
          }
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blue, // Set the color of the spinner
                ),
              ),
            ),
          );
        }
        //return a circular progress indicator while the data is being fetched with a white backgroun
      },
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Incomplete Profile'),
          content:
              const Text('Please complete your profile to access this feature'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
