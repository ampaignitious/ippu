import 'package:flutter/material.dart';
import 'package:ippu/Providers/ProfilePicProvider.dart';
import 'package:ippu/Providers/auth.dart';
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
import 'package:shared_preferences/shared_preferences.dart';


class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  AuthController authController = AuthController();
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
 
  @override
  Widget build(BuildContext context) {
      final userData = Provider.of<UserProvider>(context).user;
      var profilePhoto = NetworkImage(context.watch<ProfilePicProvider>().profilePic);
      final profileStatus = context.watch<UserProvider>().profileStatusCheck;
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
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 42, 129, 201),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: profilePhoto,
                    ),
                  accountName: Text(userData!.name), accountEmail: Text(userData.email)),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const DefaultScreen();
                  }));
                },
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.home),
                    title: Text("Home", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
              ),
              InkWell(
                onTap:(){
                  //check if profile is incomplete
                  if(profileStatus==true){
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
                    leading: const Icon(Icons.cast_for_education),
                    title: Text("Education Background", style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
              ),
               InkWell(
                onTap: (){
                  //check if profile is incomplete
                  if(profileStatus==true){
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
                    leading: const Icon(Icons.info),
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
                  if(profileStatus==true){
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
                    leading: const Icon(Icons.work_history),
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
                  if(profileStatus==true){
                          Navigator.pop(context);
                          _showDialog();
                  }
                  else{
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const EventsScreen();
                  }));
                  }
                },
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.event),
                    title: Text("Events", style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
              ),
                InkWell(
                  onTap: (){
                  //check if profile is incomplete
                  if(profileStatus==true){
                          Navigator.pop(context);
                          _showDialog();
                  }
                  else{
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const CpdsScreen();
                  }));
                  }
                },
                  child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.workspace_premium),
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
                  if(profileStatus==true){
                          Navigator.pop(context);
                          _showDialog();
                  }
                  else{
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const JobsScreen();
                  }));
                  }
                },
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.link),
                    title: Text("Jobs", style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const WhoWeAre();
                  }));
                },
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.album_outlined),
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
                    return const OurCoreValues();
                  }));
                },
                 child: const Card(
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
                    return const SettingsScreen();
                  }));
                },
                 child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.settings,
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
                  int user_id = userData.id;
                  final response = await authController.signOut();
                  //check if response does not contain error
                  if (!response.containsKey('error')) {
                    //clear shared preferences
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    await DefaultCacheManager().emptyCache();

                    context.read<AuthProvider>().isLoggedIn();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    //show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Logout Failed"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
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