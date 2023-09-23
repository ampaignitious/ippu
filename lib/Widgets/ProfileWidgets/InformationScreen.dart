import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
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
    bool isSubscription = true;

  @override
  void initState() {
    super.initState();
  Timer(Duration(seconds: 10), () {
    setState(() {
      isSubscription = false;
    });
  });
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
    final cpds = Provider.of<UserProvider>(context).CPDS;
    final event = Provider.of<UserProvider>(context).Events;
    final size = MediaQuery.of(context).size;
    final status  =    Provider.of<UserProvider>(context, listen: false).getSubscriptionStatus;
    return  FutureBuilder<ProfileData>(
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
                  String subscriptionStatus;
                  if(snapshot.data!.data['latest_membership']==null){
                  Provider.of<UserProvider>(context).setSubscriptionStatus('Not specified');

                  }else if(snapshot.data!.data['latest_membership']['status'] != null){
                  Provider.of<UserProvider>(context).setSubscriptionStatus('${snapshot.data!.data['latest_membership']['status']}');

                  }
                  return Column(
                children: [
                // SizedBox(height: size.height*0.008),
                // setSubscriptionStatus
                // 
                // displaying subscription status
                SizedBox(height: size.height*0.008),
                status == "inactive"?Center(
                  child: Container(
                    height: size.height*0.06,
                    width: size.width*0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromARGB(255, 42, 129, 201),
                      boxShadow: [
                        BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // Adjust shadow color and opacity
                        offset: Offset(0.8, 1.0), // Adjust the shadow offset
                        blurRadius: 4.0, // Adjust the blur radius
                        spreadRadius: 0.2, // Adjust the spread radius
                            ),
                          ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height*0.008,
                                  left: size.width*0.034),
                                child: Text("Subscription State",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: size.height*0.018,
                                  fontWeight: FontWeight.bold
                                ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: size.width*0.034),
                                child: Text("${status}",
                                style: GoogleFonts.lato(
                                  fontSize: size.height*0.015,
                                  color: Colors.white,
                                ),
                                ),
                              ),
                            ],
                          ),
                          // 
                    // status != "Approved"?InkWell(
                    //   onTap: (){
                    //     sendRequest();
                    //   },
                    //   child: Container(
                    //   height: size.height*0.06,
                    //   width: size.width*0.55,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(2),
                    //     color: Colors.green[500],
                    //     boxShadow: [
                    //       BoxShadow(
                    //       color: Colors.grey.withOpacity(0.2), // Adjust shadow color and opacity
                    //       offset: Offset(0.8, 1.0), // Adjust the shadow offset
                    //       blurRadius: 4.0, // Adjust the blur radius
                    //       spreadRadius: 0.2, // Adjust the spread radius
                    //           ),
                    //         ],
                    //   ),
                      
                    //            child: Column(
                    //              crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Padding(
                    //               padding: EdgeInsets.only(left: size.width*0.029,
                    //               top: size.height*0.012,
                    //               ),
                    
                    //                 child: Text("Click to subscribe",
                    //                 style: GoogleFonts.lato(
                    //                   color: Colors.white,
                    //                   fontSize: size.height*0.022,
                    //                   fontWeight: FontWeight.bold
                    //                 ),
                    //                 ),
                    //               ),
                    //             ],
                    //                                    ),
                    //          ),
                    // ):Text(""),
                        // 
                        ],
                      ),
                      ),
                      // 
                      
                      ),
                ):Text(''),
                // 
                SizedBox(height: size.height*0.012),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/image9.png'),
                ),
                SizedBox(height: size.height * 0.014),
                Text(
                  "${userData!.name}",
                  style: GoogleFonts.lato(fontSize: size.height*0.03, fontWeight: FontWeight.bold),
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
                                  Card(child: ListTile(
                  title: Text("Email"),
                  subtitle: Text("${snapshot.data!.data['email']}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Gender"),
                  subtitle: Text("${snapshot.data!.data['gender']}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Date of birth"),
                  subtitle: Text("${snapshot.data!.data['dob']}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Membership number"),
                  subtitle: Text("${snapshot.data!.data['membership_number']}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Address"),
                  subtitle: Text("${snapshot.data!.data['address']}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Phone number"),
                  subtitle: Text("${snapshot.data!.data['phone_no']}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Alt Phone number"),
                  subtitle: Text("${snapshot.data!.data['alt_phone_no']}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Next of Kin name"),
                  subtitle: Text("${snapshot.data!.data['nok_name']}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Next of Kin address"),
                  subtitle: Text("${snapshot.data!.data['nok_address']}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Next of Kin phone number"),
                  subtitle: Text("${snapshot.data!.data['nok_phone_no']}"),
                 )),

                 //  
            SizedBox(height: size.height * 0.02),
            Divider(),
            SizedBox(height: size.height * 0.02),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("My Certificates (23)", style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: size.height*0.028
                  ),),
                  
                  Icon(Icons.workspace_premium)
            
                ],
              ),
            ),
            // 
            SizedBox(height: size.height * 0.02),
            Divider(),
            SizedBox(height: size.height * 0.02),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return EducationBackgroundScreen();
                }));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Education background", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: size.height*0.028
                    ),),
                    
                    Icon(Icons.cast_for_education)
              
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Divider(),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Working Experience", style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: size.height*0.028
                  ),),
                  
                  Icon( Icons.work_history)
            
                ],
              ),
            ),
                   SizedBox(height: size.height*0.12),
                  
                    ],
                  );
                 },
                ),
               );
              }
            },
          );
        }
          Future<void> sendRequest( ) async {
    final userData = Provider.of<UserProvider>(context, listen: false).user;
  final url = 'https://ippu.org/api/subscribe';

  // Create the request body
  final body = {
    'user_id': userData!.id.toString(),
    'auth_token': userData.token,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      body: body,
    );

    if (response.statusCode == 200) {
      // Successful response, return the response body as a message
      showBottomNotification('Application submitted successfully, check your email address');
      

    } else {
      // If the request was not successful, throw an exception
      throw Exception('Failed to send request: ${response.statusCode}');
    }
  } catch (error) {
    // Handle any errors that occurred during the request
    throw Exception('Failed to send request: $error');
  }
}
void showBottomNotification(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}
}
 