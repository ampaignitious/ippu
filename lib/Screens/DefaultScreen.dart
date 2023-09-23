import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ippu/Screens/CommunicationScreen.dart';
import 'package:ippu/Screens/CpdsScreen.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/Screens/HomeScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ippu/models/AllEventsModel.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
 
class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  int _selectedIndex = 0;
  List Page = [
 HomeScreen(),
 CpdsScreen(),
 EventsScreen(),
 CommunicationScreen(),

   ];
    void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    }
      @override
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

// checking subscription
  Future<ProfileData> fetchProfileData() async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;
  if (userData == null) {
    throw Exception('User data is null');
  }

  final String apiUrl = 'https://ippu.org/api/profile/${userData.id}';
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer ${userData.token}',
    },
  );

  if (response.statusCode == 200) {
    return ProfileData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load profile data');
  }
}
// 
// 
// fetching events 
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
  Widget build(BuildContext context) {
      Provider.of<UserProvider>(context).totalNumberOfEvents(fetchedData.length);
    final size =MediaQuery.of(context).size;

    return Scaffold(
      body: Page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
       backgroundColor: Color.fromARGB(255, 42, 129, 201).withOpacity(0.9),
        currentIndex: _selectedIndex,
        onTap: ((value) => onItemTapped(value)),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 169, 230, 216).withOpacity(0.5),
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.workspace_premium), label: 'CPD'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Communication'),
        ],
      ),
    );
  }
    void showBottomNotification(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}
}
class ProfileData {
  final Map<String, dynamic> data;

  ProfileData({required this.data});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(data: json['data']);
  }
}