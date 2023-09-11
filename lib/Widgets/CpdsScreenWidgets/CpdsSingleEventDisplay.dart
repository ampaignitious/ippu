import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ippu/models/UserProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class CpdsSingleEventDisplay extends StatefulWidget {
  String imagelink;
  String cpdsname;
  String startDate;
  String endDate;
  String type;
  String location;
  String attendees;
  String content;
  String cpdId;
  String target_group;
  CpdsSingleEventDisplay({super.key, required this.cpdId, required this.location, required this.startDate, required this.endDate, required this.type, required this.content ,required this.target_group,  required this.attendees, required this.cpdsname, required this.imagelink});

  @override
  State<CpdsSingleEventDisplay> createState() => _CpdsSingleEventDisplayState(this.cpdId, this.location, this.content , this.target_group ,this.attendees, this.cpdsname, this.imagelink, this.startDate, this.endDate, this.type);
}

class _CpdsSingleEventDisplayState extends State<CpdsSingleEventDisplay> {
  @override
  String imagelink;
  String cpdsname;
  String startDate;
  String endDate;
  String type;
  String cpdId;
  String location;
  String attendees;
  String content;
  String target_group;
_CpdsSingleEventDisplayState( this.cpdId, this.content , this.location, this.target_group ,this.attendees, this.cpdsname, this.imagelink, this.startDate, this.endDate, this.type); 
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
                child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:  Color.fromARGB(255, 42, 129, 201), // Change button color to green
                            padding: EdgeInsets.all(size.height * 0.024),

                          ),
                          onPressed: (){
                         sendAttendanceRequest( cpdId);
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
  
void sendAttendanceRequest(String cpdID) async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;
  final userId = userData?.id; // Replace with your actual user ID

  final apiUrl = Uri.parse('http://app.ippu.or.ug/api/cpds/attend');

  // Create a map of the data to send
  final Map<String, dynamic> requestBody = {
    'user_id': userId,
    'cpd_id': cpdID,
  };

  try {
    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Handle a successful API response
      CircularProgressIndicator();
      print("Attendence registered successfully");
      showBottomNotification('Attendance for event sent successfully');

      
      // Navigator.pop(context);
    } else {
        // Handle errors or unsuccessful response
        print('Failed to send data to API');
         print('Failed to send data to API. Status code: ${response.statusCode}');
  print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle network errors or exceptions
      print('Error: $error');
    }
  }

  // 
void showBottomNotification(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}
}