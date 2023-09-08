import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Screens/EducationBackgroundScreen.dart';


class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}
        // "id": 30,
        // "name": "ampa",
        // "email": "ignitiousampa08@gmail.com",
        // "membership_number": "2",
        // "address": "Kampala",
        // "gender": "Male",
        // "dob": "2022-03-17",
        // "phone_no": "0786740604",
        // "alt_phone_no": null,
        // "email_verified_at": "2023-09-06T07:11:57.000000Z",
        // "account_type_id": 1,
        // "user_type": "Member",
        // "status": "Inactive",
        // "comment": null,
        // "subscribed": 0,
        // "default_pipeline": null,
        // "points": "43",
        // "created_at": "2023-09-06T07:04:06.000000Z",
        // "updated_at": "2023-09-07T10:41:31.000000Z",
        // "active_status": 0,
        // "avatar": "avatar.png",
        // "dark_mode": 0,
        // "messenger_color": null,
        // "nok_name": "Atuha",
        // "nok_address": "Atuha@gmail.com",
        // "nok_phone_no": "0786740604"

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
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
                  'Username',
                  style: GoogleFonts.lato(fontSize: size.height*0.03, fontWeight: FontWeight.bold),
                ),
                Text(
                  'user@gmail.com',
                  style: GoogleFonts.lato(color: Colors.grey),
                ),
                SizedBox(height: size.height * 0.02),
                Divider(height: 1),
                Card(
                  child: ListTile(
                   title: Text("Name"),
                  subtitle: Text("Username"),
                 )),
                 Card(child: ListTile(
                  title: Text("Email"),
                  subtitle: Text("User@gmail.com"),
                 )),
                 Card(child: ListTile(
                  title: Text("Attended CPDS"),
                  subtitle: Text(" 349"),
                 )),
                 Card(child: ListTile(
                  title: Text("Attended Events"),
                  subtitle: Text("24"),
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