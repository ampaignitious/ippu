import 'package:flutter/material.dart';
import 'package:ippu/Screens/CommunicationScreen.dart';
import 'package:ippu/Screens/DefaultScreen.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/Screens/HomeScreen.dart';
import 'package:ippu/Screens/OurCoreValues.dart';
import 'package:ippu/Screens/SettingsScreen.dart';
import 'package:ippu/Screens/WhoWeAreScreen.dart';
import 'package:ippu/Screens/WorkExperience.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/LoginScreen.dart';
import 'package:google_fonts/google_fonts.dart';



class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                currentAccountPicture: CircleAvatar(backgroundImage: AssetImage('assets/image4.png'),),
                accountName: Text("username"), accountEmail: Text("user@gmail.com")),
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
              Card(
                child: ListTile(
                  leading: Icon(Icons.cast_for_education),
                  title: Text("Education Background", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.message_rounded),
                  title: Text("Chat", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),),
                ),
              ),
              // 
               InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return CommunicationScreen();
                  }));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                  return WorkExperience();
                }));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return EventsScreen();
                  }));
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
                          Card(
                child: ListTile(
                  leading: Icon(Icons.workspace_premium),
                  title: Text("CPD", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),),
                ),
              ),
              // 
              // 
              Card(
                child: ListTile(
                  leading: Icon(Icons.link),
                  title: Text("Jobs", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),),
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
                    title: Text("Settings", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),),
                  ),
                           ),
               ),
              // 
              //  
               InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return LoginScreen();
                  }));
                },
                 child: Card(
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app_rounded,
                    color: Colors.red,
                    ),
                    title: Text("Logout", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                    ),),
                  ),
                           ),
               ),
              //  
            ],
          ),
    );
  }
}