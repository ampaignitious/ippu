import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CommunicationScreenWidgets/ContianerDiplayingCommunications.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
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
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: size.width*0.06),
              child: Icon(Icons.notifications_active),
            ),
          )
        ],
        title: Text("Communication Page", style: TextStyle(fontSize: size.height*0.02),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Available communications"),
            ),
            Container(
              height: size.height*0.8,
              width: double.maxFinite,
              child: ContainerDisplayingCommunications(),
            ),
          ],
        ),
      )
    );
  }
}