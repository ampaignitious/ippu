import 'package:clean_dialog/clean_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/controllers/auth_controller.dart';

class AttendedSingleCpdDisplay extends StatefulWidget {

  String? imagelink;
  String? cpdsname;
  String? startDate;
  String? endDate;
  String? type;
  String? location;

  String? content;
  String? target_group;
  String eventId;

  AttendedSingleCpdDisplay(
      {super.key,
      this.location,
      this.startDate,
      this.endDate,
      this.type,
      this.content,
      this.target_group,
      this.cpdsname,
      this.imagelink,
      required this.eventId});

  @override
  State<AttendedSingleCpdDisplay> createState() =>
      _AttendedSingleCpdDisplayState(
          this.content,
          this.location,
          this.target_group,
          this.cpdsname,
          this.imagelink,
          this.startDate,
          this.endDate,
          this.type, this.eventId);
}

class _AttendedSingleCpdDisplayState extends State<AttendedSingleCpdDisplay> {
 
  String? imagelink;
  String? cpdsname;
  String? startDate;
  String? endDate;
  String? type;
  String? location;
  String eventId;

  String? content;
  String? target_group;
  _AttendedSingleCpdDisplayState(this.content, this.location, this.target_group,
      this.cpdsname, this.imagelink, this.startDate, this.endDate, this.type, this.eventId);

    @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 42, 129, 201),
        title: Text("$cpdsname", style: const TextStyle(color: Colors.white),)
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.008,
              ),
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
                          DecorationImage(image: NetworkImage("$imagelink"))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.004),
                child: Text(
                  "Name",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.06, top: size.height * 0.0008),
                  child: Text("${cpdsname}")),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.016),
                child: const Text(
                  "Description",
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
                  data: content,
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
                // Text("${content}", textAlign: TextAlign.justify,),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.016),
                child: const Text(
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
                  "$target_group",
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
                            "$startDate",
                            style: TextStyle(fontSize: size.height * 0.008),
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
                            "$endDate",
                            style: TextStyle(fontSize: size.height * 0.008),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
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
                          const Text(
                            "Location",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            "$location",
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
                    backgroundColor: Color.fromARGB(
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.height * 0.02,
                      ),
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

    Future<void> renderCertificateInBrowser(String eventId) async {
    AuthController authController = AuthController();
    try {
      final response =
          await authController.downloadCpdCertificate(int.parse(eventId));
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
}
