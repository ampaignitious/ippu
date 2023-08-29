import 'package:flutter/material.dart';
import 'package:ippu/Screens/CommunicationScreen.dart';
import 'package:ippu/Screens/CpdsScreen.dart';
import 'package:ippu/Screens/EventsScreen.dart';
import 'package:ippu/Screens/HomeScreen.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';

// import '../widgets/drawerWidgets/DrawerWidget.dart';
// import 'HomeScreen.dart';
// import 'MessageScreen/MessageScreen.dart';
// import 'ReportScreen.dart';
// import 'ServiceScreen.dart';
// import 'SettingScreen.dart';


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
//  HomeScreen(),This will have the settings page
//  ServiceScreen(),
//  ReportScreen(),
//  SettingScreen(),

        ];
    void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    }
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      // drawer:Drawer(
      //   width: size.width*0.8,
      //   child: DrawerWidget(),
      // ),

      body: Page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
       backgroundColor: Color.fromARGB(255, 42, 129, 201).withOpacity(0.9),
        currentIndex: _selectedIndex,
        onTap: ((value) => onItemTapped(value)),
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        // type: BottomNavigationBarType.shifting,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 169, 230, 216).withOpacity(0.5),
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.workspace_premium), label: 'CPD'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Communication'),
          // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.settings),
          //     label: 'Settings'),

        ],
      ),
    );
  }
}