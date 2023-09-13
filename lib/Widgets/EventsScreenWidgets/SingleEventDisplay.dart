import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/PaymentScreen.dart';
 



class SingleEventDisplay extends StatefulWidget {
  String imagelink;
  String eventName;
  String rate;
  String startDate;
  String endDate;
  String points;
  String id;
  String description;
  SingleEventDisplay({super.key, required this.id, required this.points , required this.description ,required this.startDate, required this.endDate, required this.rate, required this.eventName, required this.imagelink});

  @override
  State<SingleEventDisplay> createState() => _SingleEventDisplayState( this.id, this.points ,this.description, this.rate, this.eventName, this.imagelink, this.startDate, this.endDate);
}

class _SingleEventDisplayState extends State<SingleEventDisplay> {
  // 
//   http://app.ippu.or.ug/api/cpds/attend(POST)
// parameters
// -user_id
// -cpd_id

  // 
  @override
  String imagelink;
  String eventName;
  String points;
  String startDate;
  String endDate;
  String description;
  String rate;
  String id;
  _SingleEventDisplayState(this.id, this.rate ,this.description,this.points, this.eventName, this.imagelink, this.startDate, this.endDate);
  // 
 int attended =0;

  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("${eventName}", style: GoogleFonts.lato(),),
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                      // margin: EdgeInsets.only(right:size.height*0.009, left:size.height*0.009),
                      height: size.height*0.46,
                      width: size.width*0.84,
                      decoration: BoxDecoration(
                    color: Colors.white,
                  boxShadow: [
                BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Adjust shadow color and opacity
            offset: Offset(0.8, 1.0), // Adjust the shadow offset
            blurRadius: 4.0, // Adjust the blur radius
            spreadRadius: 0.2, // Adjust the spread radius
                )],
                        image: DecorationImage(image: NetworkImage("${imagelink}"))
                      ),
                    ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.008),
                child: Text("Event Name", style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold, 
                   color: Colors.blue,
                  fontSize: size.height*0.027
                ),),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.0022),
                // child: Text("this will be about learning sessions"),
                child: Text("${eventName}", style: GoogleFonts.lato(
                 
                ),),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.019),
                child: Text("Description", style: GoogleFonts.lato(
                  fontSize: size.height*0.027,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold, 
                ),),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.02, top: size.height*0.0019),
                // child: Text("this will be about learning sessions"),
                child:Html(
  data: description,
  style: {
    "p": Style( // Apply style to <p> tags
      fontSize: FontSize(16.0),
      color: Colors.black,
      // Add more style properties as needed
    ),
    "h1": Style( // Apply style to <h1> tags
      fontSize: FontSize(24.0),
      fontWeight: FontWeight.bold,
      color: Colors.blue,
      // Add more style properties as needed
    ),
    // Add more style definitions for other HTML elements
  },
),
                 
              ),
 
              SizedBox(height: size.height*0.016,),
              // container displaying the start, end rate and location
              Container(
                margin: EdgeInsets.only(left: size.width*0.03),
                height: size.height*0.08,
                width: size.width*0.96,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey,
                    offset: Offset(0.4, 0.2),
                    blurRadius: 0.2,
                    spreadRadius: 0.4,
                    )
                  ],
                ),
                child: Padding(
                  padding:EdgeInsets.only(top:size.height*0.017),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Start Date", style: TextStyle(color: Colors.green),),
                          Text("${startDate}", style: TextStyle(fontSize: size.height*0.008),)
                        ],
                      ),
                                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("End Date", style: TextStyle(color: Colors.green),),
                          Text("${endDate}", style: TextStyle(fontSize: size.height*0.008),)
                        ],
                      ),
                                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rate", style: TextStyle(color: Colors.red),),
                          Text("${points}", style: TextStyle(fontSize: size.height*0.008),)
                        ],
                      ),
                                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Points", style: TextStyle(color: Colors.red),),
                          Text("${rate}", style: TextStyle(fontSize: size.height*0.008),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // 
              SizedBox(height: size.height*0.022,),
              // 
              Center(
                child:  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 42, 129, 201), // Change button color to green
                            padding: EdgeInsets.all(size.height * 0.024),

                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return PaymentScreen(eventAmount: points, eventId: id, eventName: eventName,);
                            }));
                            
                      // sendAttendanceRequest(id);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width*0.12),
                            child: Text('Register to Attend', style: GoogleFonts.lato(),),
                          ),
                ), ),
           
              // 
              // 
              SizedBox(height: size.height*0.022,),
              //
            ],
          ),
        ),
      ),
    );
  }

}