import 'package:flutter/material.dart';
import 'package:ippu/Screens/CommunicationScreen.dart';
import 'package:ippu/Screens/DefaultScreen.dart';
import 'package:ippu/Screens/EducationBackgroundScreen.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/Screens/JobsScreen.dart';
import 'package:ippu/Screens/CpdsScreen.dart';
import 'package:ippu/Screens/OurCoreValues.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ippu/Screens/ProfileScreen.dart';
import 'package:ippu/Screens/SettingsScreen.dart';
import 'package:ippu/Screens/WhoWeAreScreen.dart';
import 'package:ippu/Screens/WorkExperience.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/LoginScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';


class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
AuthController authController = AuthController();
// logout logic 
 void performLogout() async {
 
authController.signOut();
 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
   
}

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Incomplete Profile'),
          content: const Text('Please complete your profile to access this feature'),
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
 
  Widget build(BuildContext context) {
      final userData = Provider.of<UserProvider>(context).user;
      // Check if user data is incomplete
    bool isProfileIncomplete() {
      if (userData!.gender == null ||
          userData.dob == null ||
          userData.phone_no == null ||
          userData.nok_name == null ||
          userData.nok_phone_no == null) {
        return false;
      } else {
        return true;
      }
    }
    return SingleChildScrollView(
      child: Column(
            children: [
              InkWell(
                onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ProfileScreen();
                }));
              },
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 42, 129, 201),
                  ),
                  currentAccountPicture: CircleAvatar(backgroundImage: AssetImage('assets/image9.png'),),
                  accountName: Text("${userData!.name}"), accountEmail: Text("${userData.email}")),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return DefaultScreen();
                  }));
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Home", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
              ),
              InkWell(
                onTap:(){
                  //check if profile is incomplete
                  if(isProfileIncomplete() == false){
                          Navigator.pop(context);
                          _showDialog();
                  }
                  else{
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const EducationBackgroundScreen();
                  }));
                  }
               
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.cast_for_education),
                    title: Text("Education Background", style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
              ),
               InkWell(
                onTap: (){
                  //check if profile is incomplete
                  if(isProfileIncomplete() == false){
                          Navigator.pop(context);
                          _showDialog();
                  }
                  else{
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const CommunicationScreen();
                  }));
                  }
                 
                },
                 child: Card(
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text("Communications", style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                             ),
               ),
              //  
              // 
              InkWell(
                onTap: (){
                //check if profile is incomplete
                  if(isProfileIncomplete() == false){
                          Navigator.pop(context);
                          _showDialog();
                  }
                  else{
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const WorkExperience();
                  }));
                  }
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.work_history),
                    title: Text("Work Experience", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
              ),
              // 
              // 
              InkWell(
                onTap: (){
                //check if profile is incomplete
                  if(isProfileIncomplete() == false){
                          Navigator.pop(context);
                          _showDialog();
                  }
                  else{
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                    return EventsScreen();
                  }));
                  }
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.event),
                    title: Text("Events", style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
              ),
                InkWell(
                  onTap: (){
                  //check if profile is incomplete
                  if(isProfileIncomplete() == false){
                          Navigator.pop(context);
                          _showDialog();
                  }
                  else{
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                    return CpdsScreen();
                  }));
                  }
                },
                  child: Card(
                  child: ListTile(
                    leading: Icon(Icons.workspace_premium),
                    title: Text("CPD", style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                              ),
                ),
              // 
              // 
              InkWell(
                onTap: (){
                 //check if profile is incomplete
                  if(isProfileIncomplete() == false){
                          Navigator.pop(context);
                          _showDialog();
                  }
                  else{
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                    return JobsScreen();
                  }));
                  }
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.link),
                    title: Text("Jobs", style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return WhoWeAre();
                  }));
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.album_outlined),
                    title: Text("Who We Are", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
              ),
              // 
               InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return OurCoreValues();
                  }));
                },
                 child: Card(
                  child: ListTile(
                    leading: Icon(Icons.admin_panel_settings_rounded),
                    title: Text("Our Core Values"),
                  ),
                             ),
               ),
                             //  
               InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return SettingsScreen();
                  }));
                },
                 child: Card(
                  child: ListTile(
                    leading: Icon(Icons.settings,
                    ),
                    title: Text("Account Settings", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),),
                  ),
                           ),
               ),
              // 
              //
              InkWell(
                onTap: () async {
                  // Clear the cache
                  await DefaultCacheManager().emptyCache();

                  // Navigate to the login screen and remove all routes from the stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app_rounded, color: Colors.red),
                    title: Text(
                      "Logout",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),    
            ],
          ),
    );
  }
}