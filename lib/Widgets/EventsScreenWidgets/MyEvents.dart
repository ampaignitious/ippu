// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ippu/controllers/auth_controller.dart';
// import 'package:ippu/models/UserProvider.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

// class MyEvents extends StatefulWidget {
//   const MyEvents({Key? key}) : super(key: key);

//   @override
//   State<MyEvents> createState() => _MyEventsState();
// }

// class _MyEventsState extends State<MyEvents> {
//   AuthController authController = AuthController();

//   Future<List<MyAttendedEvents>> fetchEventsData() async {
//     final userData = Provider.of<UserProvider>(context, listen: false).user;

//     // Define the URL with userData.id
//     final apiUrl = 'http://app.ippu.or.ug/api/attended-events/${userData?.id}';

//     // Define the headers with the bearer token
//     final headers = {
//       'Authorization': 'Bearer ${userData?.token}',
//     };

//     try {
//       final response = await http.get(Uri.parse(apiUrl), headers: headers);
//       if (response.statusCode == 200) {
//         List<dynamic> jsonData = jsonDecode(response.body);
//         List<MyAttendedEvents> eventsData = jsonData.map((item) {
//           return MyAttendedEvents(
//             id: item['id'],
//             name: item['name'],
//             start_date: item['start_date'],
//             end_date: item['end_date'],
//             rate: item['rate'],
//             member_rate: item['member_rate'],
//             points: item['points'],
//             attachment_name: item['attachment_name'],
//             banner_name: item['banner_name'],
//             details: item['details'],
//           );
//         }).toList();
//         return eventsData;
//       } else {
//         throw Exception('Failed to load events data');
//       }
//     } catch (error) {
//       // Handle the error here, e.g., display an error message to the user
//       print('Error: $error');
//       return []; // Return an empty list or handle the error in your UI
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: FutureBuilder<List<MyAttendedEvents>>(
//         future: fetchEventsData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text("Check your internet connection to load the data"),
//             );
//           } else if (snapshot.hasData) {
//             List<MyAttendedEvents> temperatureData = snapshot.data!;
//             return ListView.builder(
//               itemCount: temperatureData.length,
//               itemBuilder: (context, index) {
//                 MyAttendedEvents data = temperatureData[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text('System ID: ${data.systemId}'),
                     
//                   ),
//                 );
//               },
//             );
//           } else {
//             return Center(child: Text('No data available'));
//           }
//         },
//       ),
//     );
//   }
// }

// class MyAttendedEvents {
//   String id;
//   String name;
//   String start_date;
//   String end_date;
//   String rate;
//   String member_rate;
//   String points;
//   String attachment_name;
//   String banner_name;
//   String details;

//   MyAttendedEvents({
//     required this.id,
//     required this.name,
//     required this.start_date,
//     required this.end_date,
//     required this.rate,
//     required this.member_rate,
//     required this.points,
//     required this.attachment_name,
//     required this.banner_name,
//     required this.details,
//   });
// }
