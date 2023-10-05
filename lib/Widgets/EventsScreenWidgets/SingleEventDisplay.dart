import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/PaymentScreen.dart';
import 'package:ippu/models/AllEventsModel.dart';

class SingleEventDisplay extends StatefulWidget {
  String imagelink;
  String eventName;
  String rate;
  String startDate;
  String endDate;
  String points;
  String id;
  bool attendance_request;
  String description;
  SingleEventDisplay(
      {super.key,
      required this.attendance_request,
      required this.id,
      required this.points,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.rate,
      required this.eventName,
      required this.imagelink});

  @override
  State<SingleEventDisplay> createState() => _SingleEventDisplayState(
      this.attendance_request,
      this.id,
      this.points,
      this.description,
      this.rate,
      this.eventName,
      this.imagelink,
      this.startDate,
      this.endDate);
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
  bool attendance_request;
  _SingleEventDisplayState(
      this.attendance_request,
      this.id,
      this.rate,
      this.description,
      this.points,
      this.eventName,
      this.imagelink,
      this.startDate,
      this.endDate);
  //
  int attended = 0;
  String attendance_status = "";

  Widget build(BuildContext context) {
    int status = showRegisterButton();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${eventName}",
          style: GoogleFonts.lato(),
        ),
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
                  height: size.height * 0.46,
                  width: size.width * 0.84,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(
                              0.5), // Adjust shadow color and opacity
                          offset: Offset(0.8, 1.0), // Adjust the shadow offset
                          blurRadius: 4.0, // Adjust the blur radius
                          spreadRadius: 0.2, // Adjust the spread radius
                        )
                      ],
                      image:
                          DecorationImage(image: NetworkImage("${imagelink}"))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.008),
                child: Text(
                  "Event Name",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: size.height * 0.027),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.0022),
                // child: Text("this will be about learning sessions"),
                child: Text(
                  "${eventName}",
                  style: GoogleFonts.lato(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.019),
                child: Text(
                  "Description",
                  style: GoogleFonts.lato(
                    fontSize: size.height * 0.027,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.02, top: size.height * 0.0019),
                // child: Text("this will be about learning sessions"),
                child: Html(
                  data: description,
                  style: {
                    "p": Style(
                      // Apply style to <p> tags
                      fontSize: FontSize(16.0),
                      color: Colors.black,
                      // Add more style properties as needed
                    ),
                    "h1": Style(
                      // Apply style to <h1> tags
                      fontSize: FontSize(24.0),
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      // Add more style properties as needed
                    ),
                    // Add more style definitions for other HTML elements
                  },
                ),
              ),

              SizedBox(
                height: size.height * 0.016,
              ),
              // container displaying the start, end rate and location
              Container(
                margin: EdgeInsets.only(left: size.width * 0.03),
                height: size.height * 0.08,
                width: size.width * 0.96,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.4, 0.2),
                      blurRadius: 0.2,
                      spreadRadius: 0.4,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.017),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Start Date",
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            "${extractDate(startDate)}",
                            style: TextStyle(fontSize: size.height * 0.008),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End Date",
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            "${extractDate(endDate)}",
                            style: TextStyle(fontSize: size.height * 0.008),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rate",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            "${points}",
                            style: TextStyle(fontSize: size.height * 0.008),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Points",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            "${rate}",
                            style: TextStyle(fontSize: size.height * 0.008),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //
              SizedBox(
                height: size.height * 0.022,
              ),
              //
              Center(
                child: (() {
                  switch (status) {
                    case 1:
                      return Text(
                        attendance_status,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      );
                    case 2:
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 42, 129,
                              201), // Change button color to green
                          padding: EdgeInsets.all(size.height * 0.024),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PaymentScreen(
                              eventAmount: points,
                              eventId: id,
                              eventName: eventName,
                            );
                          }));

                          // sendAttendanceRequest(id);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.12),
                          child: Text(
                            'Register to Attend',
                            style: GoogleFonts.lato(),
                          ),
                        ),
                      );
                    case 3:
                      return Text(
                        attendance_status,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      );
                    case 4:
                      return Text(
                        attendance_status,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      );
                    case 5:
                      return Text(
                        attendance_status,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      );
                    case 6:
                      return Text(
                        attendance_status,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      );
                    case 7:
                      return Text(
                        attendance_status,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      );
                    case 8:
                      return Text(
                        attendance_status,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      );
                    case 9:
                      return Text(
                        attendance_status,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      );
                    case 10:
                      return Text(
                        attendance_status,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      );
                    default:
                      return Container(); // Handle other cases if needed
                  }
                })(),
              ),
              //
              //
              SizedBox(
                height: size.height * 0.022,
              ),
              //
            ],
          ),
        ),
      ),
    );
  }

  //
  String extractDate(String fullDate) {
    // Split the full date at the 'T' to separate the date and time
    List<String> parts = fullDate.split('T');

    // Return the date part
    return parts[0];
  }

  //function to decide whether to show the register button or not, or show missed or already registered for the event
  //based on the attendance_request and the start and end date of the event
  int showRegisterButton() {
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime.parse(this.startDate);
    DateTime endDate = DateTime.parse(this.endDate);
    int statusCode = 0;

    //check if the event is still valid
    if (attendance_request == false) {
      if (currentDate.isAfter(endDate)) {
        attendance_status = "You missed this event";
        statusCode = 1;
      }

      if (currentDate.isBefore(startDate)) {
        {
          //show attend button
          attendance_status = "Pending";
          statusCode = 2;
        }
      }

      if (currentDate.isAfter(startDate) && currentDate.isBefore(endDate)) {
        attendance_status = "This event is happening but you did not register for it";
        statusCode = 3;
      }

      //check if the date is at the same momement
      if (currentDate.isAtSameMomentAs(startDate)) {
        attendance_status = "This event is happening but you did not register for it";
        statusCode = 4;
      }

      if (currentDate.isAtSameMomentAs(endDate)) {
        attendance_status = "This event is happening but you did not register for it";
        statusCode = 5;
      }
    } else {
      if (currentDate.isAfter(endDate)) {
        attendance_status = "Thank you For Attending the Event";
        statusCode = 6;
      }

      if (currentDate.isBefore(startDate)) {
        {
          attendance_status = "Already Registered to attend";
          statusCode = 7;
        }
      }

      if (currentDate.isAfter(startDate) && currentDate.isBefore(endDate)) {
        attendance_status =
            "Thank you for registering for the event, it is happening now";
        statusCode = 8;
      }

      //check if the date is at the same momement
      if (currentDate.isAtSameMomentAs(startDate)) {
        attendance_status =
            "Thank you for registering for the event, it is happening now";
        statusCode = 9;
      }

      if (currentDate.isAtSameMomentAs(endDate)) {
        attendance_status =
            "Thank you for registering for the event, it is happening now";
        statusCode = 10;
      }
    }

    return statusCode;
  }
}
