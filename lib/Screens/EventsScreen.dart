import 'package:flutter/material.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/ContainerDisplayingEvents.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/ContainerDisplayingUpcomingEvents.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
        title: Text("Events page", style: GoogleFonts.lato(
          fontSize: size.height*0.02
        ),),
        elevation: 0,
        actions: [
          Row(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(right: size.width*0.02),
                  child: Icon(Icons.notifications_on),
                ),
              ),
              // 
              Padding(
                padding: EdgeInsets.only(right: size.width*0.02),
                child: Text("34534 new events", style: GoogleFonts.lato(
                  fontSize: size.height*0.014,
                  letterSpacing:1,
                   ),),
              )
              // 
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height*0.04,),
            Padding(
              padding: EdgeInsets.only(left: size.height*0.028),
              child: Text("All Events", style: GoogleFonts.lato(
                fontSize: size.height*0.024, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8)
              ),),
            ),
            SizedBox(height: size.height*0.0045,),
            Divider(
              thickness: 1,
            ),
            SizedBox(height: size.height*0.002,),
            // this container has the container that returns the CPds
            Container(
            height: size.height*0.525,
            width: double.maxFinite,
            decoration: BoxDecoration(
              // color: Colors.blue,
            ),
            child: ContainerDIsplayingEvents()),

            // this section displays upcoming CPDS
            Padding(
              padding: EdgeInsets.only(left: size.height*0.028),
              child: Text("Upcoming Events", style: GoogleFonts.lato(
            fontSize: size.height*0.024, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8)
              ),),
            ),
            SizedBox(height: size.height*0.0045,),
            Divider(
              thickness: 1,
            ),
            SizedBox(height: size.height*0.002,),
            // this container has the container that returns the CPds
            Container(
            height: size.height*0.55,
            width: double.maxFinite,
            decoration: BoxDecoration(
              // color: Colors.blue,
            ),
            child: ContainerDisplayingUpcomingEvents()),
          ],
        ),
      ),
    );
  }
}