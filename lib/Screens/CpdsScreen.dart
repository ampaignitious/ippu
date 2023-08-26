import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/ContainerDisplayingCpds.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/ContainerDisplayingUpcomingCpds.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';
import 'package:google_fonts/google_fonts.dart';

class CpdsScreen extends StatefulWidget {
  const CpdsScreen({super.key});

  @override
  State<CpdsScreen> createState() => _CpdsScreenState();
}

class _CpdsScreenState extends State<CpdsScreen> {
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
              child: Text("Total: 234,345"),
            ),
          )
        ],
        title: Text("CPDS page", style: GoogleFonts.lato(
          fontSize: size.height*0.02
        ),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height*0.04,),
            Padding(
              padding: EdgeInsets.only(left: size.height*0.028),
              child: Text("All CPDS", style: GoogleFonts.lato(
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
            child: ContainerDisplayingCpds()),

            // this section displays upcoming CPDS
            Padding(
              padding: EdgeInsets.only(left: size.height*0.028),
              child: Text("Upcoming CPDS", style: TextStyle(fontSize: size.height*0.024, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8)),),
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
            child: ContainerDisplayingUpcomingCpds()),
          ],
        ),
      ),
    );
  }
}