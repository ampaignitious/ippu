import 'package:flutter/material.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';

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
        title: Column(
          children: [
            // Text("Sales Trackers and Monitoring App", style: TextStyle(fontSize: size.height*0.019),),
            SizedBox(height: size.height*0.009,),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: size.height*0.35,
            width: size.width*1,
            decoration: BoxDecoration(
              color: Color.fromARGB(210, 63, 131, 187),
            ),
          )
        ],
      ),
    );
  }
}