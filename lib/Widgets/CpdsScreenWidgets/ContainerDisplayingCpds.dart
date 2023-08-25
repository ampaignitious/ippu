import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/CpdsSingleEventDisplay.dart';


class ContainerDisplayingCpds extends StatefulWidget {
  const ContainerDisplayingCpds({super.key});

  @override
  State<ContainerDisplayingCpds> createState() => _ContainerDisplayingCpdsState();
}

class _ContainerDisplayingCpdsState extends State<ContainerDisplayingCpds> with TickerProviderStateMixin {
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
    List attendees = [
    "20",
    "5",
    "100",
    "2",
    "1",
  ];
  @override
  Widget build(BuildContext context) {
final size = MediaQuery.of(context).size;
   return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context,index){
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return CpdsSingleEventDisplay(attendees: attendees[index], imagelink: 'assets/cpds${index}.jpg', cpdsname: activityname[index],);
            }));
          },
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right:size.height*0.009, left:size.height*0.009),
                height: size.height*0.4,
                width: size.width*0.7,
                decoration: BoxDecoration(
                  
                  image: DecorationImage(image: AssetImage("assets/cpds${index}.jpg"))
                ),
              ),
              SizedBox(height:size.height*0.006),
              Container(
                height: size.height*0.085,
                width: size.width*0.7,
                decoration: BoxDecoration(
                  color: Colors.blue
                ),
                child: Center(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:size.height*0.008),
                    Text("${activityname[index]}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: size.height*0.02),),
                    SizedBox(height:size.height*0.008),
                    Text("${attendees[index]} Attendees", style: TextStyle(color: Colors.white),)
                  ],
                )))
            ],
          ),
        );
      }
    );
  }
}