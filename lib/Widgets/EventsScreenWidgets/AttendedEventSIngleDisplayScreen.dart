import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:clean_dialog/clean_dialog.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class AttendedEventSIngleDisplayScreen extends StatefulWidget {
  String name;
  String eventId;
  String details;
  String points;
  String imageLink;
  String rate;
  String start_date;
  String end_date;

  AttendedEventSIngleDisplayScreen(
      {super.key,
      required this.eventId,
      required this.start_date,
      required this.end_date,
      required this.name,
      required this.details,
      required this.imageLink,
      required this.points,
      required this.rate});

  @override
  State<AttendedEventSIngleDisplayScreen> createState() =>
      _AttendedEventSIngleDisplayScreenState(
        this.eventId,
        this.start_date,
        this.end_date,
        this.details,
        this.imageLink,
        this.name,
        this.points,
        this.rate,
      );
}

class _AttendedEventSIngleDisplayScreenState
    extends State<AttendedEventSIngleDisplayScreen> {

  String name;
  String details;
  String points;
  String imageLink;
  String rate;
  String start_date;
  String end_date;
  String eventId;
  _AttendedEventSIngleDisplayScreenState(
    this.eventId,
    this.start_date,
    this.end_date,
    this.details,
    this.imageLink,
    this.name,
    this.points,
    this.rate,
  );

  double _progress = 0.0;
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("${name}"),
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
                      border: Border.all(
                        color: Colors.lightBlue,
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://ippu.org/storage/banners/${imageLink}"))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.004),
                child: Text(
                  "Event name",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.0008),
                child: Text("${name}"),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.016),
                child: Text(
                  "Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06,
                    right: size.width * 0.06,
                    top: size.height * 0.0016),
                child: Html(
                  data: details,
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

                // Text("${details}", textAlign: TextAlign.justify,),
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
                            "${start_date}",
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
                            "${end_date}",
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
                            "${points}",
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        255, 42, 129, 201), // Change button color to green
                    padding: EdgeInsets.all(size.height * 0.024),
                  ),
                  onPressed: () {
                    renderCertificateInBrowser(eventId);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.12),
                    child: Text(
                      'Download certificate',
                      style: GoogleFonts.lato(),
                    ),
                  ),
                ),
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => CleanDialog(
        title: 'Certificate Downloaded',
        content: 'Certificate saved in downloads folder',
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
        actions: [
          CleanDialogActionButtons(
            actionTitle: 'OK',
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  //
  // printing certificate
  Future<void> renderCertificateInBrowser(String eventId) async {
    AuthController authController = AuthController();
    try {
      final response =
          await authController.downloadEventCertificate(int.parse(eventId));
      //check if response does not contain any error key
      if (response.containsKey('error')) {
        //show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Certificate download failed"),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        //certificate key from response
        FileDownloader.downloadFile(
          url: response['certificate'],
          name: 'certificate.pdf',
          downloadDestination: DownloadDestinations.appFiles,
        );
        //show dialog
        _showDialog();
      }
    } catch (e) {
      //show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Certificate download failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
