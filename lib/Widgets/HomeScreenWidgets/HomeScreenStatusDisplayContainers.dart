// import 'package:flutter/material.dart';
// import 'package:ippu/Widgets/HomeScreenWidgets/FirstSetOfRows.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ippu/Screens/CommunicationScreen.dart';
// import 'package:ippu/Screens/CpdsScreen.dart';
// import 'package:ippu/Screens/EventsScreen.dart';
// import 'package:ippu/Screens/JobsScreen.dart';
// import 'package:ippu/Screens/UserAppGuide.dart';
// import 'package:ippu/Widgets/CpdsScreenWidgets/AttendedCpdsScreen.dart';
// import 'package:ippu/Widgets/HomeScreenWidgets/FirstSetOfRows.dart';
// import 'package:ippu/Widgets/HomeScreenWidgets/HomeScreenStatusDisplayContainers.dart';
// import 'package:ippu/Widgets/HomeScreenWidgets/SecondSetOfRows.dart';
// import 'package:ippu/Widgets/HomeScreenWidgets/StatDisplayRow.dart';
// import 'package:ippu/controllers/auth_controller.dart';
// import 'package:ippu/models/UserProvider.dart';
// import 'package:provider/provider.dart';

// class HomeScreenStatusDisplayContainers extends StatefulWidget {
//   const HomeScreenStatusDisplayContainers({super.key});

//   @override
//   State<HomeScreenStatusDisplayContainers> createState() => _HomeScreenStatusDisplayContainersState();
// }

// class _HomeScreenStatusDisplayContainersState extends State<HomeScreenStatusDisplayContainers> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Column(
//               children: [
//                 SizedBox(height: size.height * 0.018),
//                 FirstSetOfRows(),
//                 SizedBox(height: size.height * 0.018),
//                 // SecondSetOfRows(),
//                 // SizedBox(height: size.height * 0.018),

//                 // 
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) {
//                       return CpdsScreen();
//                     }));
//                   },
//                   child: Container(
//                     height: size.height * 0.098,
//                     width: size.width * 0.9,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       gradient: LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 42, 129, 201),
//                           // Color.fromARGB(200, 139, 195, 74),
//                           Color.fromARGB(255, 42, 129, 201),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.white,
//                             offset: Offset(0.8, 0.3),
//                             blurRadius: 0.3,
//                             spreadRadius: 0.3),
//                         BoxShadow(
//                             color: Colors.grey,
//                             offset: Offset(0.3, 0.9),
//                             blurRadius: 0.3,
//                             spreadRadius: 0.3),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.07),
//                           child: Icon(
//                             Icons.workspace_premium,
//                             color: Colors.white,
//                             size: size.height * 0.040,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.055),
//                           child: Text(
//                             "Check out all CPDS",
//                             style: TextStyle(color: Colors.white, fontSize: size.height * 0.022),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.07),
//                           child: Container(
//                             height: size.height * 0.06,
//                             width: size.width * 0.20,
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.white),
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Center(child: Text("${cpds}", style: TextStyle(color: Colors.white))),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // 

//                 SizedBox(height: size.height * 0.024),

//                 // 
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) {
//                       return EventsScreen();
//                     }));
//                   },
//                   child: Container(
//                     height: size.height * 0.098,
//                     width: size.width * 0.9,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       gradient: LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 42, 129, 201),
//                           Color.fromARGB(255, 42, 201, 161),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.white,
//                             offset: Offset(0.8, 0.3),
//                             blurRadius: 0.3,
//                             spreadRadius: 0.3),
//                         BoxShadow(
//                             color: Colors.grey,
//                             offset: Offset(0.3, 0.9),
//                             blurRadius: 0.3,
//                             spreadRadius: 0.3),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.07),
//                           child: Icon(
//                             Icons.event,
//                             color: Colors.white,
//                             size: size.height * 0.040,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.055),
//                           child: Text(
//                             "Check out all events",
//                             style: TextStyle(color: Colors.white, fontSize: size.height * 0.022),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.07),
//                           child: Container(
//                             height: size.height * 0.06,
//                             width: size.width * 0.20,
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.white),
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Center(child: Text("${event}", style: TextStyle(color: Colors.white))),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // 
//                 SizedBox(height: size.height * 0.024),

//                 // 
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) {
//                       return CommunicationScreen();
//                     }));
//                   },
//                   child: Container(
//                     height: size.height * 0.098,
//                     width: size.width * 0.9,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       gradient: LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 42, 129, 201),
//                           Color.fromARGB(255, 42, 129, 201),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.white,
//                             offset: Offset(0.8, 0.3),
//                             blurRadius: 0.3,
//                             spreadRadius: 0.3),
//                         BoxShadow(
//                             color: Colors.grey,
//                             offset: Offset(0.3, 0.9),
//                             blurRadius: 0.3,
//                             spreadRadius: 0.3),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.05),
//                           child: Icon(
//                             Icons.info,
//                             color: Colors.white,
//                             size: size.height * 0.040,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.055),
//                           child: Text(
//                             "Available communication",
//                             style: TextStyle(color: Colors.white, fontSize: size.height * 0.019),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.04),
//                           child: Container(
//                             height: size.height * 0.06,
//                             width: size.width * 0.20,
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.white),
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Center(child: Text("${communications}", style: TextStyle(color: Colors.white))),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
                
//                 // 

//                 SizedBox(height: size.height * 0.024),

//                 // 
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) {
//                       return JobsScreen();
//                     }));
//                   },
//                   child: Container(
//                     height: size.height * 0.098,
//                     width: size.width * 0.9,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       gradient: LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 42, 129, 201),
//                           Color.fromARGB(255, 42, 201, 161),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.white,
//                             offset: Offset(0.8, 0.3),
//                             blurRadius: 0.3,
//                             spreadRadius: 0.3),
//                         BoxShadow(
//                             color: Colors.grey,
//                             offset: Offset(0.3, 0.9),
//                             blurRadius: 0.3,
//                             spreadRadius: 0.3),
//                       ],
//                     ),
//                     child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.05),
//                           child: Icon(
//                             Icons.info,
//                             color: Colors.white,
//                             size: size.height * 0.040,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.055),
//                           child: Text(
//                             "Available jobs",
//                             style: TextStyle(color: Colors.white, fontSize: size.height * 0.020),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.04),
//                           child: Container(
//                             height: size.height * 0.06,
//                             width: size.width * 0.20,
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.white),
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Center(child: Text("${communications}", style: TextStyle(color: Colors.white))),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.024),


//                 // 
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) {
//                       return UserAppGuide();
//                     }));
//                   },
//                   child: Container(
//                     height: size.height * 0.098,
//                     width: size.width * 0.9,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       gradient: LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 42, 129, 201),
//                           Color.fromARGB(255, 42, 129, 201),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.white,
//                             offset: Offset(0.8, 0.3),
//                             blurRadius: 0.3,
//                             spreadRadius: 0.3),
//                         BoxShadow(
//                             color: Colors.grey,
//                             offset: Offset(0.3, 0.9),
//                             blurRadius: 0.3,
//                             spreadRadius: 0.3),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.07),
//                           child: Icon(
//                             Icons.supervised_user_circle,
//                             color: Colors.white,
//                             size: size.height * 0.040,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: size.width * 0.055),
//                           child: Text(
//                             "click to see app user guide",
//                             style: TextStyle(color: Colors.white, fontSize: size.height * 0.022),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
              
//               // 
//               ],
//             );
//   }
// }