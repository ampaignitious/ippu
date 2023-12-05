import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ippu/Providers/ProfilePicProvider.dart';
import 'package:ippu/Screens/EducationBackgroundScreen.dart';
import 'package:ippu/models/UserProvider.dart';
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


  @override
  void initState() {
    super.initState();
    fetchProfileData();
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

  Future<ProfileData> fetchProfileData() async {
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
      return ProfileData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context).user;
    final size = MediaQuery.of(context).size;
    var profilePhoto = NetworkImage(context.watch<ProfilePicProvider>().profilePic);

    final status =
        Provider.of<UserProvider>(context, listen: false).getSubscriptionStatus;
    return FutureBuilder<ProfileData>(
      future: fetchProfileData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
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
                      "${userData!.name}",
                      style: GoogleFonts.lato(
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${userData.email}',
                      style: GoogleFonts.lato(color: Colors.grey),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Divider(height: 1),
                    Card(
                        child: ListTile(
                      title: Text("Name"),
                      subtitle: Text("${snapshot.data!.data['name']}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Email"),
                      subtitle: Text("${snapshot.data!.data['email']}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Gender"),
                      subtitle: Text("${snapshot.data!.data['gender']}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Date of birth"),
                      subtitle: Text("${snapshot.data!.data['dob']}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Membership number"),
                      subtitle:
                          Text("${snapshot.data!.data['membership_number']}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Address"),
                      subtitle: Text("${snapshot.data!.data['address']}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Phone number"),
                      subtitle: Text("${snapshot.data!.data['phone_no']}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Alt Phone number"),
                      subtitle: Text("${snapshot.data!.data['alt_phone_no']}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Next of Kin name"),
                      subtitle: Text("${snapshot.data!.data['nok_name']}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Next of Kin address"),
                      subtitle: Text("${snapshot.data!.data['nok_address']}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text("Next of Kin phone number"),
                      subtitle: Text("${snapshot.data!.data['nok_phone_no']}"),
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
        }
      },
    );
  }

  Future<int> certificateCount() async {
    final userData = Provider.of<UserProvider>(context, listen: false).user;
    final apiUrl = 'http://app.ippu.or.ug/api/attended-events/${userData?.id}';
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
}
