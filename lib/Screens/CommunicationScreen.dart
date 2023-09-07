import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CommunicationScreenWidgets/ContainerDiplayingCommunications.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final communication = Provider.of<UserProvider>(context).totalCommunications;
    return Scaffold(
            drawer:Drawer(
        width: size.width*0.8,
        child: DrawerWidget(),
      ),
    appBar: AppBar(
              // leading: Icon(Icons.menu),
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: size.width*0.06),
              child: Icon(Icons.notifications_active),
            ),
          )
        ],
        title: Text("Communication Page", style: TextStyle(fontSize: size.height*0.02),),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Text("Available communications"),
            // ),
            SizedBox(height: size.height*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // this shows all communication
                Column(
                  children: [
                    Container(
                      height: size.height*0.08,
                      width: size.width*0.4,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 42, 129, 201),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 24,  
                                  ),
                              Center(
                                child: Text("${communication}", style: GoogleFonts.lato(
                                  color: Colors.white,
                                                    
                                ),),
                              ),
                            ],
                          ),
                      
                        ],
                      ),
                    ),
                    SizedBox(height: size.height*0.008,),
                    Text("All communications", style: GoogleFonts.lato(
                      fontSize:size.height*0.016,
                    ),)
                  ],
                ),
              //  this shows unread communication
              Column(
                  children: [
                    Container(
                      height: size.height*0.08,
                      width: size.width*0.4,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 50, 155, 132),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.new_releases,
                                color: Colors.white, 
                                size: 24, 
                              ),
                              Center(
                                child: Text("${communication}", style: GoogleFonts.lato(
                                  color: Colors.white,
                                                    
                                ),),
                              ),
                            ],
                          ),
                      
                        ],
                      ),
                    ),
                    SizedBox(height: size.height*0.008,),
                    Text("Unread communications", style: GoogleFonts.lato(
                      fontSize:size.height*0.016,
                      color: Colors.red,
                    ),)
                  ],
                ),
              // 
              ],
            ),
            SizedBox(height: size.height*0.02,),
            Padding(
              padding: EdgeInsets.only(left: size.width*0.036),
              child: Text("Click to read more about the communication", style: GoogleFonts.roboto(
                fontSize:size.height*0.019,
                color: Colors.black.withOpacity(0.5)
              ),),
            ),
            SizedBox(height: size.height*0.008,),
            Container(
              height: size.height*0.6,
              width: double.maxFinite,
              child: ContainerDisplayingCommunications(),
            ),
          ],
        ),
      )
    );
  }
}