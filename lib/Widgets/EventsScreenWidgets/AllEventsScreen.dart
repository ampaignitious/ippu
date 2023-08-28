import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/ContainerDisplayingEvents.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/ContainerDisplayingUpcomingEvents.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({super.key});

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
            height: size.height*0.625,
            width: double.maxFinite,
            decoration: BoxDecoration(
              // color: Colors.blue,
            ),
            child: ContainerDIsplayingEvents()),
          ],
        ),
      );
  }
}