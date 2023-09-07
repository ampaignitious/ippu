import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Screens/CommunicationScreen.dart';
import 'package:ippu/Screens/CpdsScreen.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/Screens/UserAppGuide.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/FirstSetOfRows.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/SecondSetOfRows.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/StatDisplayRow.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class FirstDisplaySection extends StatefulWidget {
  const FirstDisplaySection({super.key});

  @override
  State<FirstDisplaySection> createState() => _FirstDisplaySectionState();
}

class _FirstDisplaySectionState extends State<FirstDisplaySection> {
  @override
int totalCPDS = 0;
  int totalEvents = 0;
  int totalCommunications =0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      AuthController authController = AuthController();
      final cpds = await authController.getCpds();
      final events = await authController.getEvents();
      final communications = await authController.getAllCommunications();
      setState(() {
        totalCPDS = cpds.length;
        totalEvents = events.length;
        totalCommunications = communications.length;
        Provider.of<UserProvider>(context, listen: false).totalNumberOfCPDS(totalCPDS);
        Provider.of<UserProvider>(context, listen: false).totalNumberOfEvents(totalEvents);
        Provider.of<UserProvider>(context, listen:false).totalNumberOfCommunications(totalCommunications);


      });
    } catch (e) {
      // Handle any errors here
      print('Error fetching data: $e');
    }
  }

  // // 
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
  final cpds = Provider.of<UserProvider>(context).CPDS;
   final event = Provider.of<UserProvider>(context).Events;
   final communications = Provider.of<UserProvider>(context).totalCommunications;
    return Stack(
      children: [
        Container(
          height: size.height * 0.30,
          width: size.width * 1,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 42, 129, 201),
          ),
          child: Column(
            children: [
              Text(
                "Welcome to IPPU mobile applications",
                style: TextStyle(color: Colors.white, fontSize: size.height * 0.016),
              ),
              SizedBox(height: size.height * 0.026),
              StatDisplayRow(),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: size.height * 0.24, left: size.width * 0.032),
          height: size.height * 0.56,
          width: size.width * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.018),
                // FirstSetOfRows(),
                // SizedBox(height: size.height * 0.018),
                // SecondSetOfRows(),
                // SizedBox(height: size.height * 0.018),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return CpdsScreen();
                    }));
                  },
                  child: Container(
                    height: size.height * 0.098,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 139, 195, 74),
                          Color.fromARGB(255, 42, 129, 201),
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
                            Icons.workspace_premium,
                            color: Colors.white,
                            size: size.height * 0.040,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.055),
                          child: Text(
                            "Check out all CPDS",
                            style: TextStyle(color: Colors.white, fontSize: size.height * 0.022),
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
                            child: Center(child: Text("${cpds}", style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.024),
                InkWell(
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
                          Colors.lightGreen,
                          Color.fromARGB(255, 42, 129, 201),
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
                            style: TextStyle(color: Colors.white, fontSize: size.height * 0.022),
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
                            child: Center(child: Text("${event}", style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.024),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return CommunicationScreen();
                    }));
                  },
                  child: Container(
                    height: size.height * 0.098,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [
                          Colors.lightGreen,
                          Color.fromARGB(255, 42, 129, 201),
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
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          child: Icon(
                            Icons.info,
                            color: Colors.white,
                            size: size.height * 0.040,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.055),
                          child: Text(
                            "Available communication",
                            style: TextStyle(color: Colors.white, fontSize: size.height * 0.020),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.04),
                          child: Container(
                            height: size.height * 0.06,
                            width: size.width * 0.20,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(child: Text("${communications}", style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.024),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return UserAppGuide();
                    }));
                  },
                  child: Container(
                    height: size.height * 0.098,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [
                          Colors.lightGreen,
                          Color.fromARGB(255, 42, 129, 201),
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
                            Icons.supervised_user_circle,
                            color: Colors.white,
                            size: size.height * 0.040,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.055),
                          child: Text(
                            "click to see app user guide",
                            style: TextStyle(color: Colors.white, fontSize: size.height * 0.022),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
