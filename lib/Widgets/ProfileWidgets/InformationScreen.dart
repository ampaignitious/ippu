import 'dart:convert';
import 'package:flutter/material.dart';
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
}
 