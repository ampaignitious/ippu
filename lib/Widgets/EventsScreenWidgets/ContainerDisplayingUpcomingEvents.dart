import 'package:flutter/material.dart';
import 'package:flutter/material.dart';


class ContainerDisplayingUpcomingEvents extends StatefulWidget {
  const ContainerDisplayingUpcomingEvents({super.key});

  @override
  State<ContainerDisplayingUpcomingEvents> createState() => _ContainerDisplayingUpcomingEventsState();
}

class _ContainerDisplayingUpcomingEventsState extends State<ContainerDisplayingUpcomingEvents> with TickerProviderStateMixin {
  List images = [
    "cpds1.jpg",
    "cpds2.jpg",
    "cpds3.jpg",
    "cpds4.jpg",
    "cpds3.jpg",
    "cpds2.jpg",
    "cpds4.jpg",
  ];
    List activityname = [
    "Contract Management",
    "Integration and implementation",
    "Sustainanle Procurement",
    "Free CPD For all",
    "Test ver 2",
  ];
  @override
  Widget build(BuildContext context) {
final size = MediaQuery.of(context).size;
   return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 3,
      itemBuilder: (context,index){
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(right:size.height*0.009, left:size.height*0.009),
              height: size.height*0.4,
                width: size.width*0.85,
              decoration: BoxDecoration(
                // border: Border.all(
                //   // color: Colors.white,
                // ),
                image: DecorationImage(image: AssetImage("assets/cpds${index}.jpg"))
              ),
            ),
            SizedBox(height:size.height*0.014),
              Container(
                height: size.height*0.085,
                width: size.width*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                  boxShadow: [
              BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Adjust shadow color and opacity
          offset: Offset(0.8, 1.0), // Adjust the shadow offset
          blurRadius: 4.0, // Adjust the blur radius
          spreadRadius: 0.2, // Adjust the spread radius
              ),]),
              child: Center(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height:size.height*0.008),
                  Center(child: Text("${activityname[index]}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: size.height*0.02),)),
                  SizedBox(height:size.height*0.008),
                  // Text("${attendees[index]} Attendees", style: TextStyle(color: Colors.white),)
                ],
              ))),
              SizedBox(height:size.height*0.022),
          ],
        );
      }
    );
  }
}