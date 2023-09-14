import 'package:flutter/material.dart';
import 'package:ippu/Screens/CommunicationScreen.dart';

class allCommunication extends StatefulWidget {
  const allCommunication({super.key});

  @override
  State<allCommunication> createState() => _allCommunicationState();
}

class _allCommunicationState extends State<allCommunication> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  InkWell(
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
                          Color.fromARGB(255, 42, 129, 201),
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
                            style: TextStyle(color: Colors.white, fontSize: size.height * 0.019),
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
                            child: Center(child: Text("${2}", style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ) 
                ;
  }
}