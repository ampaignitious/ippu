import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleCommunicationDisplayScreen extends StatefulWidget {
  String communicationtitle;
  String communicationbody;
 SingleCommunicationDisplayScreen({super.key, required this.communicationbody, required this.communicationtitle});

  @override
  State<SingleCommunicationDisplayScreen> createState() => _SingleCommunicationDisplayScreenState(this.communicationbody, this.communicationtitle);
}

class _SingleCommunicationDisplayScreenState extends State<SingleCommunicationDisplayScreen> {
  @override
    String communicationtitle;
  String communicationbody;
  _SingleCommunicationDisplayScreenState(this.communicationbody, this.communicationtitle);
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        title: Padding(
                      padding: EdgeInsets.only(left: size.width*0.02,  right: size.width*0.016,),
                      child: Text("${communicationtitle}", style: GoogleFonts.roboto(
                  fontSize: size.height*0.02,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ), )),
        elevation: 0,
      ),
      body: Container(
                margin: EdgeInsets.only(right:size.height*0.009, left:size.height*0.0098, top: size.height*0.02),
                height: size.height*0.8,
                width: size.width*0.96,
                decoration: BoxDecoration(
                  color: Colors.white,
                boxShadow: [
              BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Adjust shadow color and opacity
          offset: Offset(0.8, 1.0), // Adjust the shadow offset
          blurRadius: 4.0, // Adjust the blur radius
          spreadRadius: 0.2, // Adjust the spread radius
              )]),
              child: Column(
                children: [
                  SizedBox(height: size.height*0.012,),
                  // communication title section
                  Padding(
                      padding: EdgeInsets.only(left: size.width*0.02, top: size.height*0.02, right: size.width*0.016,),
                      child: Text("${communicationtitle}", style: GoogleFonts.roboto(
                  fontSize: size.height*0.02,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: Color.fromARGB(255, 7, 63, 109),
                ), )),
                  // 

                  // communication body section
                  Divider(),
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.066, top: size.height*0.008, right: size.width*0.04, bottom: size.height*0.008,),
                      child: Text("${communicationbody}"),
                    ),
                  // 

                  // date and time section
                  Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        // 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date", style: GoogleFonts.lato(
                                color:Colors.green,
                                fontWeight: FontWeight.bold
                              ),),
                              Text("July 4, 2023, 12:00 am", style: GoogleFonts.roboto(
                                fontSize:size.height*0.016,
                              ),)
                            ],
                          ),
                        // 
                        ],
                      ),
                    ),
                  // 
                ],
              ),
              ),
    );
  }
}