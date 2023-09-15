import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Screens/EducationBackgroundScreen.dart';
import 'package:ippu/models/ProfileModel.dart';
import 'package:http/http.dart' as http;
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';


class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}
class _InfoScreenState extends State<InfoScreen> {
  @override
 
 
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context).user;
    final cpds = Provider.of<UserProvider>(context).CPDS;
    final event = Provider.of<UserProvider>(context).Events;


    final size =MediaQuery.of(context).size;
    return Column(
      children: [
                SizedBox(height: 20),
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
                  subtitle: Text("${userData.name}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Email"),
                  subtitle: Text("${userData.email}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Gender"),
                  subtitle: Text("${userData.gender}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Date of birth"),
                  subtitle: Text("${userData.dob}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Membership number"),
                  subtitle: Text("${userData.membership_number}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Address"),
                  subtitle: Text("${userData.address}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Phone number"),
                  subtitle: Text("${userData.phone_no}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Alt Phone number"),
                  subtitle: Text("${userData.alt_phone_no}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Next of Kin name"),
                  subtitle: Text("${userData.nok_name}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Next of Kin address"),
                  subtitle: Text("${userData.nok_address}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Next of Kin phone number"),
                  subtitle: Text("${userData.nok_phone_no}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Attended CPDS"),
                  subtitle: Text("${cpds}"),
                 )),
                 Card(child: ListTile(
                  title: Text("Attended Events"),
                  subtitle: Text("${event}"),
                 )),
                 SizedBox(height: size.height * 0.02),
                //  
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
            SizedBox(height: size.height * 0.02),
            Divider(),
      ],
    );
  }
}