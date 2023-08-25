import 'package:flutter/material.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/FirstDisplaySection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
            drawer:Drawer(
        width: size.width*0.8,
        child: DrawerWidget(),
      ),
      appBar: AppBar(
              // leading: Icon(Icons.menu),
        backgroundColor: Color.fromARGB(210, 63, 131, 187),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: size.width*0.06),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/image9.png'),
              backgroundColor: Colors.white,
            ),
          )
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          FirstDisplaySection(),
         ],
      ),
    );
  }
}