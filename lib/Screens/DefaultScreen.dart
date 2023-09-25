import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ippu/Screens/CommunicationScreen.dart';
import 'package:ippu/Screens/CpdsScreen.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/Screens/HomeScreen.dart';
import 'dart:convert';
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

  Widget build(BuildContext context) {
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
