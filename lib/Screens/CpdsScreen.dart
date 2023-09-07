import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/AllCpdsScreen.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/AttendedCpdsScreen.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/UpcomingCpdsScreen.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class CpdsScreen extends StatefulWidget {
  const CpdsScreen({super.key});

  @override
  State<CpdsScreen> createState() => _CpdsScreenState();
}

class _CpdsScreenState extends State<CpdsScreen> with TickerProviderStateMixin{

  late TabController _cpdTabController;

  @override
  void initState() {
    super.initState();
    _cpdTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _cpdTabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
  final cpds = Provider.of<UserProvider>(context).CPDS;
  final size = MediaQuery.of(context).size;
  
    return Scaffold(
      drawer:Drawer(
        width: size.width*0.8,
        child: DrawerWidget(),
      ),
    appBar: AppBar(
     
      flexibleSpace: Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [
            //     Color.fromARGB(210, 63, 131, 187), // Blue color
            //     Colors.lightGreen, // Light green color
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
            color:Color.fromARGB(255, 42, 129, 201)
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: size.width*0.06),
              child: Text("All Cpds: ${cpds}"),
            ),
          )
        ],
        title: Text("CPD Trainings", style: GoogleFonts.lato(
          fontSize: size.height*0.02
        ),),
        elevation: 0,
        // 
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _cpdTabController,
          tabs: [
            Tab(
              child: Row(children: [
                Icon(Icons.workspace_premium,
                size:size.height*0.014,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width*0.008
                  ),
                  child: Text("All CPDS", style: GoogleFonts.lato(
                    fontSize: size.height*0.014,
                  ),),
                ),
              ]),
            ),
            Tab(
              child: Row(children: [
                Icon(Icons.timeline,
                size:size.height*0.014,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width*0.004
                  ),
                  child: Text("Upcoming CPDS", style: GoogleFonts.lato(
                    fontSize: size.height*0.0135,
                  ),),
                ),
              ]),
            ),
            Tab(
              child: Row(children: [
                Icon(Icons.event_seat,
                size:size.height*0.014,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width*0.008
                  ),
                  child: Text("Attended cpds", style: GoogleFonts.lato(
                    fontSize: size.height*0.014,
                  ),),
                ),
              ]),
            ),
          ],
        ),
        // 
      ),
      body: TabBarView(
        controller: _cpdTabController,
        children: [
          AllCpdsScreen(),
          UpcommingCpdsScreen(),
          AttendedCpdsScreen(),
        ],
      ),
    );
  }
}