import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:clean_dialog/clean_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ippu/Providers/ProfilePicProvider.dart';
import 'package:ippu/Providers/SubscriptionStatus.dart';
import 'package:ippu/Screens/EducationBackgroundScreen.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:ippu/main.dart';
import 'package:ippu/models/UserData.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


class ProfileData {
  final Map<String, dynamic> data;

  ProfileData({required this.data});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(data: json['data']);
  }
}

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  bool isProfileIncomplete = true;
  int numberOfCertificates = 0;
  final ImagePicker _picker = ImagePicker();
  late File _image;
  late Future<UserData> profileData;

  @override
  void initState() {
    super.initState();
    profileData = loadProfile();
    _fetchAttendedEventsCount(); // Call the method to fetch attended events count
  }


   Future<void> _fetchAttendedEventsCount() async {
    try {
      final count = await certificateCount();
      setState(() {
        numberOfCertificates = count;
      });
    } catch (error) {
      print('Error fetching attended events count: $error');
    }
  }

 Future<UserData> loadProfile() async {
  AuthController authController = AuthController();
  try {
    final response = await authController.getProfile();
    if (response.containsKey("error")) {
      throw Exception("The return is an error");
    } else {
      if (response['data'] != null) {
        // Access the user object directly from the 'data' key
        Map<String, dynamic> userData = response['data'];
        
        UserData profile = UserData(
          id: userData['id'],
          name: userData['name'] ?? "",
          email: userData['email'] ?? "",
          gender: userData['gender']??"",
          dob: userData['dob'] ?? "",
          membership_number: userData['membership_number'] ?? "",
          address: userData['address'] ?? "",
          phone_no: userData['phone_no'] ?? "",
          alt_phone_no: userData['alt_phone_no'] ?? "",
          nok_name: userData['nok_name'] ?? "",
          nok_address: userData['nok_address'] ?? "",
          nok_phone_no: userData['nok_phone_no'] ?? "",
          points: userData['points'] ?? "",
          subscription_status: userData['subscription_status'].toString(),
          profile_pic: userData['profile_pic'] ??
              "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png",
        );

        return profile;
      } else {
        // Handle the case where the 'data' field in the API response is null
        throw Exception("You currently have no data");
      }
    }
  } catch (error) {
    print("catched error: $error");
    throw Exception("An error occurred while loading the profile");
  }
}

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context).user;
    final size = MediaQuery.of(context).size;
    var profilePhoto = NetworkImage(context.watch<ProfilePicProvider>().profilePic);

      String? status= context.watch<SubscriptionStatusProvider>().status;

    return FutureBuilder(
    future: profileData, 
    builder: (context, snapshot){
      if(snapshot.hasData){
        final profileData = snapshot.data as UserData;
         return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: size.height * 0.008),

                    SizedBox(height: size.height * 0.012),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: profilePhoto,
                    ),
                    
                    SizedBox(height: size.height * 0.014),
                    Text(
                      userData!.name,
                      style: GoogleFonts.lato(
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userData.email,
                      style: GoogleFonts.lato(color: Colors.grey),
                    ),
                    SizedBox(height: size.height * 0.02),
                    // add download membership certificate button
                    if(status == 'Approved')
                    ElevatedButton(
                            onPressed: () {
                              //download membership certificate
                              renderCertificateInBrowser();
                            },
                            child: const Text("Download Membership Certificate"),
                          ),
                                   const Divider(height: 1),
                    Card(
                        child: ListTile(
                      title: Text("Name"),
                      subtitle: Text("${profileData.name}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Email"),
                      subtitle: Text("${profileData.email}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Gender"),
                      subtitle: Text("${profileData.gender}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Date of birth"),
                      subtitle: Text("${profileData.dob}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Membership number"),
                      subtitle:
                          Text("${profileData.membership_number}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Address"),
                      subtitle: Text("${profileData.address}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Phone number"),
                      subtitle: Text("${profileData.phone_no}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Alt Phone number"),
                      subtitle: Text("${profileData.alt_phone_no}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Next of Kin name"),
                      subtitle: Text("${profileData.nok_name}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Next of Kin address"),
                      subtitle: Text("${profileData.nok_address}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Next of Kin phone number"),
                      subtitle: Text("${profileData.nok_phone_no}"),
                    )),

                    //
                    SizedBox(height: size.height * 0.02),
                    Divider(),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.12),
                      child: GestureDetector(
                        onTap: (){
                          //naviagate to my events screen
                          Navigator.pushNamed(context, '/myevents');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Certificates ($numberOfCertificates )',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.height * 0.028),
                            ),
                            Icon(Icons.workspace_premium)
                          ],
                        ),
                      ),
                    ),
                    //
                    SizedBox(height: size.height * 0.02),
                    Divider(),
                    SizedBox(height: size.height * 0.02),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EducationBackgroundScreen();
                        }));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.12),
                        child: GestureDetector(
                          onTap: (){
                            //navigate to education background screen
                            Navigator.pushNamed(context, '/educationbackground');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Education background",
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.028),
                              ),
                              Icon(Icons.cast_for_education)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Divider(),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.12),
                      child: GestureDetector(
                        onTap: (){
                          //navigate to communication screen
                          Navigator.pushNamed(context, '/workexperience');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Working Experience",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.height * 0.028),
                            ),
                            Icon(Icons.work_history)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.12),
                  ],
                );
              },
            ),
          );
      } else if(snapshot.hasError){
        return Center(child: Text("An error occured while loading your profile"));
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }
    );
  }

  Future<int> certificateCount() async {
    final userData = Provider.of<UserProvider>(context, listen: false).user;
    final apiUrl = 'https://ippu.org/api/attended-events/${userData?.id}';
    final headers = {
      'Authorization': 'Bearer ${userData?.token}',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<dynamic> eventData = jsonData['data'];
        // Return the count of attended events
        return eventData.length;
      } else {
        throw Exception('Failed to load events data');
      }
    } catch (error) {
      // Handle the error here, e.g., display an error message to the user
      print('Error: $error');
      return 0; // Return 0 or handle the error count in your UI
    }
  }

Future<void> renderCertificateInBrowser() async {
  AuthController authController = AuthController();
  try {
    final response = await authController.downloadMembershipCertificate();

    if (response.containsKey('error')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Certificate download failed"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
        //ask for storage write permission
        final status = await Permission.storage.request();
        if (status.isGranted) {
          //certificate key from response
          FileDownloader.downloadFile(
            url: response['certificate'],
            name: 'certificate.png',
          );
          //show dialog
          _showDialog();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Permission to save certificate to storage denied"),
              backgroundColor: Colors.red,
            ),
          );
        }
      
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Certificate download failed"),
        backgroundColor: Colors.red,
      ),
    );
  }
}



    void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Certificate Downloaded',
        content: 'Certificate saved in downloads folder',
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
        actions: [
          CleanDialogActionButtons(
            actionTitle: 'OK',
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
