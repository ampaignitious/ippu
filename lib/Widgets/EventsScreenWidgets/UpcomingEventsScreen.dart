import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/ContainerDisplayingUpcomingEvents.dart';

class UpcomingEventsScreen extends StatefulWidget {
  const UpcomingEventsScreen({super.key});

  @override
  State<UpcomingEventsScreen> createState() => _UpcomingEventsScreenState();
}

class _UpcomingEventsScreenState extends State<UpcomingEventsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height*0.04,),
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
            height: size.height*0.65,
            width: double.maxFinite,
            decoration: BoxDecoration(
              // color: Colors.blue,
            ),
            child: ContainerDisplayingUpcomingEvents()),
          ],
        ),
      );
  }
}