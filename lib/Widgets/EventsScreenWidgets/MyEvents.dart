import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/AttendedEventSIngleDisplayScreen.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:ippu/models/MyAttendedEvents.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_html/flutter_html.dart';


class MyEvents extends StatefulWidget {
  const MyEvents({Key? key}) : super(key: key);

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
    late Future<List<MyAttendedEvents>> eventDataFuture;

  @override
  void initState() {
    super.initState();
    eventDataFuture = fetchEventsData();
 
  }
  Future<List<MyAttendedEvents>> fetchEventsData() async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;

  // Define the URL with userData.id
  final apiUrl = 'https://ippu.org/api/api/attended-events/${userData?.id}';

  // Define the headers with the bearer token
  final headers = {
    'Authorization': 'Bearer ${userData?.token}',
  };

  try {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> eventData = jsonData['data'];
      List<MyAttendedEvents> eventsData = eventData.map((item) {
        return MyAttendedEvents(
          id: item['id'].toString(),
          name: item['name'],
          start_date: item['start_date'],
          end_date: item['end_date'],
          rate: item['rate'],
          member_rate: item['member_rate'],
          points: item['points'].toString(), // Convert points to string if needed
          attachment_name: item['attachment_name'],
          banner_name: item['banner_name'],
          details: item['details'],
        );
      }).toList();
      return eventsData;
    } else {
      throw Exception('Failed to load events data');
    }
  } catch (error) {
    // Handle the error here, e.g., display an error message to the user
    print('Error: $error');
    return []; // Return an empty list or handle the error in your UI
  }
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
 
          SizedBox(
            height: size.height*0.006,
          ),
          Center(
            child: Container(
              height: size.height*0.70,
              width: size.width*0.9,
           
              child: FutureBuilder<List<MyAttendedEvents>>(
                future: eventDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Check your internet connection to load the data"),
                    );
                  } else if (snapshot.hasData) {
                    List<MyAttendedEvents> eventData  = snapshot.data!;
                    return ListView.builder(
                      itemCount: eventData .length,
                      itemBuilder: (context, index) {
                        MyAttendedEvents data = eventData [index];
                        return Column(
                          children: [
                            Container(
                              height: size.height*0.46,
                              width: size.width*0.84,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(0.8, 1.0),
                                blurRadius: 4.0,
                                spreadRadius: 0.2,
                              ),
                            ],
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)
                                ),
                               ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Center(
                                  child: Container(
                                    height: size.height*0.22,
                                                  width: size.width*0.56,
                                                  decoration: BoxDecoration(
                                  // border: Border.all(
                                  //   color: Colors.lightBlue,
                                  // ),
                                  image: DecorationImage(image: NetworkImage("https://ippu.org/storage/banners/${data.banner_name}"))
                                                  ),
                                  ),
                                ),
                                Divider(),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                    padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.004),
                                    child: Text("Event name", style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height*0.04,
                                    ),),
                              ),
                                Padding(
                                padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.0008),
                                child: Text("${data.name.split(' ').take(3).join(' ')}", style: TextStyle(
                                  color: Colors.blue
                                ),),
                              ),
                                  ],
                                ),
                              Padding(
                                padding: EdgeInsets.only(right: size.width*0.07),
                                child: Column(
                                  children: [
                                Padding(
                                 padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.016),
                                  child: Text("Points", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.justify ,),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: size.width*0.06, right:size.width*0.06, top: size.height*0.0016),
                                  child: Text("${data.points}", textAlign: TextAlign.justify, style: TextStyle(
                                    color: Colors.blue
                                  ),),
                                ),
                                  ],
                                ),
                              ),
                               
                                ],
                               ),
                      SizedBox(
            
                            height: size.height*0.024,
                      ),
                              
                      Center(
                            child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary:  Color.fromARGB(255, 42, 129, 201), // Change button color to green
                                        padding: EdgeInsets.all( size.height * 0.020),
                                  
                                      ),
                                      onPressed: (){
                                        print(data);
                                        print(data.id);
          
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                              return AttendedEventSIngleDisplayScreen(eventId: data.id, start_date: data.start_date, end_date: data.end_date, details: data.details, points: data.points, rate: data.rate, name: data.name, imageLink: data.banner_name,);
                            }));
                                      },
                                      child: Text('Click to view more information', style: GoogleFonts.lato(),),
                            ),
                      ),
                                 
                                ],
                              ),
                            ),
                            SizedBox(height:size.height*0.016),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
