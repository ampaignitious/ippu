
import 'package:flutter/material.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
 

class allEventDisplay extends StatefulWidget {
  const allEventDisplay({super.key});

  @override
  State<allEventDisplay> createState() => _allEventDisplayState();
}

class _allEventDisplayState extends State<allEventDisplay> {

// 
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     final eventPoints = Provider.of<UserProvider>(context).EventsPoints;
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
                            child: Center(child: Text("${eventPoints}", style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
;
  }
}