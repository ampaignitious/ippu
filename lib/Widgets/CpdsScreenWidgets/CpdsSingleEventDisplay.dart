import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/CpdPaymentScreen.dart';

class CpdsSingleEventDisplay extends StatefulWidget {
  String imagelink;
  String cpdsname;
  String startDate;
  String endDate;
  String type;
  String location;
  bool attendance_request;
  String attendees;
  String content;
  String cpdId;
  String rate;
  String target_group;
  CpdsSingleEventDisplay(
      {super.key,
      required this.attendance_request,
      required this.rate,
      required this.cpdId,
      required this.location,
      required this.startDate,
      required this.endDate,
      required this.type,
      required this.content,
      required this.target_group,
      required this.attendees,
      required this.cpdsname,
      required this.imagelink});

  @override
  State<CpdsSingleEventDisplay> createState() => _CpdsSingleEventDisplayState(
      this.attendance_request,
      this.cpdId,
      this.rate,
      this.location,
      this.content,
      this.target_group,
      this.attendees,
      this.cpdsname,
      this.imagelink,
      this.startDate,
      this.endDate,
      this.type);
}

class _CpdsSingleEventDisplayState extends State<CpdsSingleEventDisplay> {
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


  _CpdsSingleEventDisplayState(
      this.attendance_request,
      this.cpdId,
      this.content,
      this.rate,
      this.location,
      this.target_group,
      this.attendees,
      this.cpdsname,
      this.imagelink,
      this.startDate,
      this.endDate,
      this.type);

  String attendance_status = "";

  @override
  Widget build(BuildContext context) {
    int status = showRegisterButton();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${cpdsname}",
            style: GoogleFonts.lato(
    textStyle: TextStyle(color: Colors.white), // Set text color to white
  ),
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
                      // border: Border.all(
                      //   // color: Colors.white,
                      // ),
                      image:
                          DecorationImage(image: NetworkImage("${imagelink}"))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.004),
                child: Text(
                  "Description",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.06, top: size.height * 0.0008),
                  child: Html(
                    data: location,
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
                  )),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.016),
                child: Text(
                  "Target Group",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06,
                    right: size.width * 0.06,
                    top: size.height * 0.0016),
                child: Text(
                  "${target_group}",
                  textAlign: TextAlign.justify,
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
                            "Type",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            "${type}",
                            style: TextStyle(fontSize: size.height * 0.008),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            "${content}",
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
                          primary: Color.fromARGB(255, 42, 129, 201),
                          padding: EdgeInsets.all(size.height * 0.024),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CpdPaymentScreen(
                              eventAmount: rate,
                              eventName: cpdsname,
                              eventId: cpdId,
                            );
                          }));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.12),
                          child: Text(
                            'Register to Attend',
                              style: GoogleFonts.lato(
    textStyle: TextStyle(color: Colors.white), // Set text color to white
  ),
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

  String extractDate(String fullDate) {
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
        attendance_status = "You missed this cpd";
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
        attendance_status =
            "This cpd is happening but you did not register for it";
        statusCode = 3;
      }

      //check if the date is at the same momement
      if (currentDate.isAtSameMomentAs(startDate)) {
        attendance_status =
            "This cpd is happening but you did not register for it";
        statusCode = 4;
      }

      if (currentDate.isAtSameMomentAs(endDate)) {
        attendance_status =
            "This cpd is happening but you did not register for it";
        statusCode = 5;
      }
    } else {
      if (currentDate.isAfter(endDate)) {
        attendance_status = "Thank you For Attending the cpd";
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
            "Thank you for registering for the cpd, it is happening now";
        statusCode = 8;
      }

      //check if the date is at the same momement
      if (currentDate.isAtSameMomentAs(startDate)) {
        attendance_status =
            "Thank you for registering for the cpd, it is happening now";
        statusCode = 9;
      }

      if (currentDate.isAtSameMomentAs(endDate)) {
        attendance_status =
            "Thank you for registering for the cpd, it is happening now";
        statusCode = 10;
      }
    }

    return statusCode;
  }
}
