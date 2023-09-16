import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
 import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/SingleEventDisplay.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:ippu/models/AllEventsModel.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class UpcomingEventsHorizontalHomeDisplay extends StatefulWidget {
  const UpcomingEventsHorizontalHomeDisplay({super.key});

  @override
  State<UpcomingEventsHorizontalHomeDisplay> createState() =>
      _UpcomingEventsHorizontalHomeDisplayState();
}

class _UpcomingEventsHorizontalHomeDisplayState
    extends State<UpcomingEventsHorizontalHomeDisplay>
    with TickerProviderStateMixin {
  AuthController authController = AuthController();

  final ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  bool _showBackToTopButton = false;
 
    late Future<List<AllEventsModel>> eventDataFuture;
  @override
  void initState() {
    super.initState();
        eventDataFuture = fetchUpComingEvents();
    _scrollController.addListener(_updateScrollVisibility);
  }

  void _updateScrollVisibility() {
    setState(() {
      _showBackToTopButton =
          _scrollController.offset > _scrollController.position.maxScrollExtent / 2;
    });
  }
  // function fetching upcoming events
    Future<List<AllEventsModel>> fetchUpComingEvents() async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;

  // Define the URL with userData.id
  final apiUrl = 'https://ippu.org/api/upcoming-events/${userData?.id}';

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  FutureBuilder<List<AllEventsModel>>(
              future: eventDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No data available');
                } else {
                  final data = snapshot.data;
                  if (data != null) {
                    return ListView.builder(
                      // controller: _scrollController,
                      // scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        // Ensure the properties accessed here match the structure of your API response
                        final eventName = item.name;
                        final startDate = item.start_date;
                        final endData =item.end_date;
                        final description = item.details;
                        final displaypoints = item.points;
                        final attendance_request = item.attandence_request;
                        final rate = item.rate;
                        final eventId = item.id.toString();
                        final imageLink = item.banner_name;
                        final points= item.points.toString();
                        if (_searchQuery.isEmpty ||
                            eventName
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              print(item.attandence_request);
                         Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return SingleEventDisplay(
                            id: eventId.toString(),
                            attendance_request: attendance_request,
                            points: points.toString(),
                            rate: rate,
                            description: description,
                            startDate: startDate ,
                            endDate: endData ,
                            imagelink: 'https://ippu.org/storage/banners/${imageLink}',
                            eventName: eventName ,
                          );
                        }),
                      );
                    },
                    child: Column(
                              children: [
                               Container(
                                height: size.height * 0.35,
                                width: size.width * 0.85,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                          child: Column(
                            children: [
                              Text("Upcoming Events",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 42, 129, 201),
                              ),
                              ),
                              SizedBox(height: size.height*0.010,),
                              Container(
                                margin: EdgeInsets.only(
                                  right: size.height * 0.009,
                                  left: size.height * 0.009,
                                ),
                                height: size.height * 0.28,
                                width: size.width * 0.62,
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
                                  image: DecorationImage(
                                    image: NetworkImage('https://ippu.org/storage/banners/${imageLink}'),
                                  ),
                                ),
                              ),
                              Text("Click to read more",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height*0.015,
                                color: Color.fromARGB(255, 42, 129, 201),
                              )),
                            ],
                          ),
                        ),],
                            ),
                          );
                        } else {
                          return Container(); // Return an empty container for non-matching items
                        }
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              },
 
    );
  }
}
