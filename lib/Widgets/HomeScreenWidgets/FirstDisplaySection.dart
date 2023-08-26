import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Screens/CommunicationScreen.dart';
import 'package:ippu/Screens/CpdsScreen.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/Screens/UserAppGuide.dart';

class FirstDisplaySection extends StatefulWidget {
  const FirstDisplaySection({super.key});

  @override
  State<FirstDisplaySection> createState() => _FirstDisplaySectionState();
}

class _FirstDisplaySectionState extends State<FirstDisplaySection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Stack(
      children: [

        Container(
                height: size.height*0.30,
                width: size.width*1,
                decoration: BoxDecoration(
                  color: Color.fromARGB(210, 63, 131, 187),
                ),
                child: Column(
                  children: [
                    Text("Welcome to IPPU mobile application", style: TextStyle(color: Colors.white, fontSize: size.height*0.016),),
                    SizedBox(height: size.height*0.026,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // the home screen section displays ( available events)
                    Container(
                    height: size.height*0.16,
                    width: size.width*0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        // the row displaying icon and text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // container containing the event icon
                            Container(
                    height: size.height*0.075,
                    width: size.width*0.10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 50, 155, 132),
                    ),
                    child: Icon(Icons.event, color: Colors.white,
                    size: size.height*0.022,
                    ),
                    ),
                    Text("Available Events", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ))
                          ],
                        ),
                        // end of the row section
                        Divider(
                          thickness: 2,
                          color: Color.fromARGB(210, 63, 131, 187),
                        ),
                    Center(child: Text("5,235", style: TextStyle(fontSize: size.height*0.0342, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 50, 155, 132), letterSpacing: 1),))
                      ],
                    ),
                    ),
                    // attend CPD
                  Container(
                    height: size.height*0.16,
                    width: size.width*0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        // the row displaying icon and text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // container containing the event icon
                            Container(
                    height: size.height*0.075,
                    width: size.width*0.10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 50, 155, 132),
                    ),
                    child: Icon(
                      Icons.workspace_premium, color: Colors.white,
                      size: size.height*0.024,
                      ),
                    ),
                    Text("Attended CPDS", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ))
                          ],
                        ),
                        // end of the row section
                        Divider(
                          thickness: 2,
                          color: Color.fromARGB(210, 63, 131, 187),
                        ),
                    Center(child: Text("125", style: TextStyle(fontSize: size.height*0.0342, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 50, 155, 132),letterSpacing: 1),))
                      ],
                    ),
                    ),
                      ],
                    ),
                  ],
                ),
              ),
        //  this is the container that has more home icons
        Container(
          margin: EdgeInsets.only(top: size.height*0.24, left: size.width*0.032 ),
                    height: size.height*0.56,
                    width: size.width*0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height*0.018,
                          ),
                      // this button is the button with the check out All CPDS
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return CpdsScreen();
                          }));
                        },
                            child: Container(
                              height: size.height*0.098,
                              width: size.width*0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                                boxShadow:[
                            BoxShadow(color: Colors.white,
                            offset:  Offset(0.8, 0.3),
                            blurRadius: 0.3,
                            spreadRadius: 0.3
                            ),
                            BoxShadow(color: Colors.grey,
                            offset:  Offset(0.3, 0.9),
                            blurRadius: 0.3,
                            spreadRadius: 0.3
                            ),
                          ],
                              ),
                              child: Row(
                                children: [
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.07),
                          child: Icon(
                          Icons.workspace_premium, color: Colors.white,
                          size: size.height*0.040,
                          ),
                        ),
                        Padding(
                         padding: EdgeInsets.only(left: size.width*0.055),
                          child: Text("Check out all CPDS", style: TextStyle(color: Colors.white, fontSize: size.height*0.022),),
                        ),
                        // this container used to put a white border around the text
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.07),
                          child: Container(
                            height: size.height*0.06,
                            width: size.width*0.20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white
                              ),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(child: Text("534,734", style: TextStyle(color: Colors.white),))),
                        )
                                ],
                              ),
                            ),
                          ),
                      // end of the button with check out all CPDS
                      SizedBox(height: size.height*0.024,),

                      // this button shows the available events
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return EventsScreen();
                          }));
                        },
                            child: Container(
                              height: size.height*0.098,
                              width: size.width*0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                                boxShadow:[
                            BoxShadow(color: Colors.white,
                            offset:  Offset(0.8, 0.3),
                            blurRadius: 0.3,
                            spreadRadius: 0.3
                            ),
                            BoxShadow(color: Colors.grey,
                            offset:  Offset(0.3, 0.9),
                            blurRadius: 0.3,
                            spreadRadius: 0.3
                            ),
                          ],
                              ),
                              child: Row(
                                children: [
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.07),
                          child: Icon(
                          Icons.event, color: Colors.white,
                          size: size.height*0.040,
                          ),
                        ),
                        Padding(
                         padding: EdgeInsets.only(left: size.width*0.055),
                          child: Text("Check out all events", style: TextStyle(color: Colors.white, fontSize: size.height*0.022),),
                        ),
                        // this container used to put a white border around the text
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.07),
                          child: Container(
                            height: size.height*0.06,
                            width: size.width*0.20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white
                              ),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(child: Text("456,234", style: TextStyle(color: Colors.white),))),
                        )
                                ],
                              ),
                            ),
                          ),
                        // end of the button that shows available events
                    SizedBox(height: size.height*0.024,),

                      // this button shows the available communication
                      InkWell(
                      onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return CommunicationScreen();
                          }));
                        },
                            child: Container(
                              height: size.height*0.098,
                              width: size.width*0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                                boxShadow:[
                            BoxShadow(color: Colors.white,
                            offset:  Offset(0.8, 0.3),
                            blurRadius: 0.3,
                            spreadRadius: 0.3
                            ),
                            BoxShadow(color: Colors.grey,
                            offset:  Offset(0.3, 0.9),
                            blurRadius: 0.3,
                            spreadRadius: 0.3
                            ),
                          ],
                              ),
                              child: Row(
                                children: [
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.05),
                          child: Icon(
                          Icons.info, color: Colors.white,
                          size: size.height*0.040,
                          ),
                        ),
                        Padding(
                         padding: EdgeInsets.only(left: size.width*0.055),
                          child: Text("Available communication", style: TextStyle(color: Colors.white, fontSize: size.height*0.020),),
                        ),
                        // this container used to put a white border around the text
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.04),
                          child: Container(
                            height: size.height*0.06,
                            width: size.width*0.20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white
                              ),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(child: Text("456,234", style: TextStyle(color: Colors.white),))),
                        )
                                ],
                              ),
                            ),
                          ),
                        // end of the button that shows available events
                
                 SizedBox(height: size.height*0.024,),

                      // this button shows the available events
                      InkWell(
                      onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return UserAppGuide();
                          }));
                        },
                            child: Container(
                              height: size.height*0.098,
                              width: size.width*0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                                boxShadow:[
                            BoxShadow(color: Colors.white,
                            offset:  Offset(0.8, 0.3),
                            blurRadius: 0.3,
                            spreadRadius: 0.3
                            ),
                            BoxShadow(color: Colors.grey,
                            offset:  Offset(0.3, 0.9),
                            blurRadius: 0.3,
                            spreadRadius: 0.3
                            ),
                          ],
                              ),
                              child: Row(
                                children: [
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.07),
                          child: Icon(
                          Icons.supervised_user_circle, color: Colors.white,
                          size: size.height*0.040,
                          ),
                        ),
                        Padding(
                         padding: EdgeInsets.only(left: size.width*0.055),
                          child: Text("click to see app user guide", style: TextStyle(color: Colors.white, fontSize: size.height*0.022),),
                        ),
                        // this container used to put a white border around the text
                      
                                ],
                              ),
                            ),
                          ),
                        // end of the button that shows available events
                        ],
                      ),
                    ),
                    ),
        // 
        
      ],
    )
        ;
  }
}