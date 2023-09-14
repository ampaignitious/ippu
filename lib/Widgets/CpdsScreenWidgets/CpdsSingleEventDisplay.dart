import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/CpdPaymentScreen.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/PaymentScreen.dart';
 


class CpdsSingleEventDisplay extends StatefulWidget {
  String imagelink;
  String cpdsname;
  String startDate;
  String endDate;
  String type;
  String location;
  bool  attendance_request;
  String attendees;
  String content;
  String cpdId;
  String rate;
  String target_group;
  CpdsSingleEventDisplay({super.key, required this.attendance_request, required this.rate, required this.cpdId, required this.location, required this.startDate, required this.endDate, required this.type, required this.content ,required this.target_group,  required this.attendees, required this.cpdsname, required this.imagelink});

  @override
  State<CpdsSingleEventDisplay> createState() => _CpdsSingleEventDisplayState(this.attendance_request,this.cpdId, this.rate, this.location, this.content , this.target_group ,this.attendees, this.cpdsname, this.imagelink, this.startDate, this.endDate, this.type);
}

class _CpdsSingleEventDisplayState extends State<CpdsSingleEventDisplay> {
  @override
  String imagelink;
  String cpdsname;
  String startDate;
  String endDate;
  String type;
  String cpdId;
  String? rate;
  String location;
  String attendees;
  String content;
  bool attendance_request;
  String target_group;
_CpdsSingleEventDisplayState(this.attendance_request, this.cpdId, this.content , this.rate, this.location, this.target_group ,this.attendees, this.cpdsname, this.imagelink, this.startDate, this.endDate, this.type); 
 Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("${cpdsname}", style: GoogleFonts.lato(),),
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
                        // border: Border.all(
                        //   // color: Colors.white,
                        // ),
                        image: DecorationImage(image: NetworkImage("${imagelink}"))
                      ),
                    ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.004),
                child: Text("Description", style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold, 
                ),),
              ),
              
              Padding(
                padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.0008),
                child: Html(
  data: location,
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
                
                // Text("${location}"),
              ),
              Padding(
               padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.016),
                child: Text("Target Group", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.justify ,),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.06, right:size.width*0.06, top: size.height*0.0016),
                child: Text("${target_group}", textAlign: TextAlign.justify,),
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
                          Text("Type", style: TextStyle(color: Colors.red),),
                          Text("${type}", style: TextStyle(fontSize: size.height*0.008),)
                        ],
                      ),
                                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location", style: TextStyle(color: Colors.red),),
                          Text("${content}", style: TextStyle(fontSize: size.height*0.008),)
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
                child:attendance_request ==true? Text("Already registered for the CPD"
                , style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                ) : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:  Color.fromARGB(255, 42, 129, 201), // Change button color to green
                            padding: EdgeInsets.all(size.height * 0.024),

                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return   CpdPaymentScreen(eventAmount:rate, eventName: cpdsname, eventId: cpdId,);

                            }));
                        //  sendAttendanceRequest( cpdId);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width*0.12),
                            child: Text('Register to Attend', style: GoogleFonts.lato(),),
                          ),
                ),
              ),
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