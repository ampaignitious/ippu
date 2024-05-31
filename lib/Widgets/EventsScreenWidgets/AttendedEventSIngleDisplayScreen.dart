import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:clean_dialog/clean_dialog.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class AttendedEventSIngleDisplayScreen extends StatefulWidget {
  final String name;
  final String eventId;
  final String details;
  final String points;
  final String imageLink;
  final String rate;
  final String start_date;
  final String end_date;
  final String status;

  const AttendedEventSIngleDisplayScreen(
      {super.key,
      required this.eventId,
      required this.start_date,
      required this.end_date,
      required this.name,
      required this.details,
      required this.imageLink,
      required this.points,
      required this.rate,
      required this.status
      });

  @override
  State<AttendedEventSIngleDisplayScreen> createState() =>
      _AttendedEventSIngleDisplayScreenState();
}

class _AttendedEventSIngleDisplayScreenState
    extends State<AttendedEventSIngleDisplayScreen> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name, style: const TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 42, 129, 201),
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
                              "https://ippu.org/storage/banners/${widget.imageLink}"))),
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
                child: Text(widget.name),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.016),
                child: const Text(
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
                  data: widget.details,
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
                decoration: const BoxDecoration(
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
                          const Text(
                            "Start Date",
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            widget.start_date,
                            style: TextStyle(fontSize: size.height * 0.012),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "End Date",
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            widget.end_date,
                            style: TextStyle(fontSize: size.height * 0.012),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Points",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            widget.points,
                            style: TextStyle(fontSize: size.height * 0.012),
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
                child: widget.status=="Attended"?ElevatedButton(
                  style: ElevatedButton.styleFrom(
                   // Change button color to green
                    padding: EdgeInsets.all(size.height * 0.024),
                  ),
                  onPressed: () {
                    renderCertificateInBrowser(widget.eventId);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.12),
                    child: Text(
                      'Download certificate',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.white), // Set text color to white
                      ),
                    ),
                  ),
                ): const Text(""),
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
          const SnackBar(
            content: Text("Certificate download failed"),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        //ask for storage write permission
        final status = await Permission.storage.request();
        if (status.isGranted) {
          //certificate key from response
          FileDownloader.downloadFile(
            url: response['certificate'],
            name: 'certificate.png',
          );
          //show dialog
          _showDialog();
        } else {
          //show error message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Storage permission denied"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      //show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Certificate download failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
