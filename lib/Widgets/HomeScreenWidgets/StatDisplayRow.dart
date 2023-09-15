import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/models/AllEventsModel.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class StatDisplayRow extends StatefulWidget {
  const StatDisplayRow({super.key});

  @override
  State<StatDisplayRow> createState() => _StatDisplayRowState();
}

class _StatDisplayRowState extends State<StatDisplayRow> {
    late Future<List<AllEventsModel>> dataFuture;
  late List<AllEventsModel> fetchedData = []; // Declare a list to store fetched data

  @override
  void initState() {
    super.initState();
    // Assign the result of fetchdata to the fetchedData list
    dataFuture = fetchAllEvents().then((data) {
      fetchedData = data;
      return data;
    });
    dataFuture = fetchAllEvents();
    print(fetchedData);
  }
// 
  Future<List<AllEventsModel>> fetchAllEvents() async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;

  // Define the URL with userData.id
  final apiUrl = 'https://ippu.org/api/events/${userData?.id}';

  // Define the headers with the bearer token
  final headers = {
    'Authorization': 'Bearer ${userData?.token}',
  };

  try {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> eventData = jsonData['data'];
      List<AllEventsModel> eventsData = eventData.map((item) {
        return AllEventsModel(
          id: item['id'].toString(),
          name: item['name'],
          start_date: item['start_date'],
          end_date: item['end_date'],
          rate: item['rate'],
          attandence_request: item['attendance_request'] ,
          member_rate: item['member_rate'],
          points: item['points'].toString(), // Convert points to string if needed
          attachment_name: item['attachment_name'],
          banner_name: item['banner_name'],
          details: item['details'],
        );
      }).toList();
      print(eventsData);
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
// 
// 

// 
  Widget build(BuildContext context) {

  Provider.of<UserProvider>(context).totalNumberOfEvents(fetchedData.length);
    final size = MediaQuery.of(context).size;
        final eventPoints = Provider.of<UserProvider>(context).EventsPoints;

  final totalCommunication = Provider.of<UserProvider>(context).totalCommunications;
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // the home screen section displays ( available events)
                    Container(
                    height: size.height*0.14,
                    width: size.width*0.42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        // the row displaying icon and text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // container containing the event icon
                            Container(
                    height: size.height*0.070,
                    width: size.width*0.10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 50, 155, 132),
                    ),
                    child: Icon(Icons.event, color: Colors.white,
                    size: size.height*0.022,
                    ),
                    ),
                    Text("Available Events", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: size.height*0.012,
                      color: Color.fromARGB(255, 42, 129, 201),
                    ))
                          ],
                        ),
                        // end of the row section
                        Divider(
                          thickness: 2,
                          color: Color.fromARGB(210, 63, 131, 187),
                        ),
                    Center(child: Text("${fetchedData.length}", style: TextStyle(fontSize: size.height*0.0342, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 50, 155, 132), letterSpacing: 1),))
                      ],
                    ),
                    ),
                    // attend CPD
                  Container(
                    height: size.height*0.14,
                    width: size.width*0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        // the row displaying icon and text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // container containing the event icon
                            Container(
                    height: size.height*0.070,
                    width: size.width*0.10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 50, 155, 132),
                    ),
                    child: Icon(
                      Icons.workspace_premium, color: Colors.white,
                      size: size.height*0.024,
                      ),
                    ),
                    Text("Available communications", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: size.height*0.012,
                      color: Color.fromARGB(255, 42, 129, 201),
                    ))
                          ],
                        ),
                        // end of the row section
                        Divider(
                          thickness: 2,
                          color: Color.fromARGB(210, 63, 131, 187),
                        ),
                    Center(child: Text("${totalCommunication}", style: TextStyle(fontSize: size.height*0.0342, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 50, 155, 132),letterSpacing: 1),))
                      ],
                    ),
                    ),
                      ],
                    )
                  ;
  }
}