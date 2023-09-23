import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/models/AllEventsModel.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class allEventDisplay extends StatefulWidget {
  const allEventDisplay({super.key});

  @override
  State<allEventDisplay> createState() => _allEventDisplayState();
}

class _allEventDisplayState extends State<allEventDisplay> {
  late Future<List<AllEventsModel>> dataFuture;
  late List<AllEventsModel> fetchedData = []; // Declare a list to store fetched data
  int totalEventPoints =0;
  @override
  void initState() {
    super.initState();
    // Assign the result of fetchdata to the fetchedData list
    dataFuture = fetchAllEvents().then((data) {
      fetchedData = data;
      for (final cpd in fetchedData) {
      int? points = int.tryParse(cpd.points);
      if (points != null) {
        totalEventPoints += points;
      }
    }
      return data;
    });
    dataFuture = fetchAllEvents();
  }
 
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
            attandence_request: item['attendance_request'],
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
  
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Provider.of<UserProvider>(context).totalNumberOfPointsFromEvents(totalEventPoints);
    final eventPoints = Provider.of<UserProvider>(context).EventsPoints;
    // Calculate the total points
    int totalPoints = 0;
    for (var event in fetchedData) {
      totalPoints += int.parse(event.points);
    }
    print(totalPoints);
    // Update the UserProvider with the total points for events
    Provider.of<UserProvider>(context, listen: false)
        .totalNumberOfEvents(fetchedData.length);

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EventsScreen();
        }));
      },
      child: Container(
        height: size.height * 0.098,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 42, 129, 201),
              Color.fromARGB(255, 42, 201, 161),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.white,
                offset: Offset(0.8, 0.3),
                blurRadius: 0.3,
                spreadRadius: 0.3),
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0.3, 0.9),
                blurRadius: 0.3,
                spreadRadius: 0.3),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.07),
              child: Icon(
                Icons.event,
                color: Colors.white,
                size: size.height * 0.040,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.055),
              child: Text(
                "Check out all events",
                style: TextStyle(
                    color: Colors.white, fontSize: size.height * 0.022),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.07),
              child: Container(
                height: size.height * 0.06,
                width: size.width * 0.20,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text("${fetchedData.length}",
                        style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
