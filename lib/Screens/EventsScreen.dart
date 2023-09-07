import 'package:flutter/material.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/AllEventsScreen.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/UpcomingEventsScreen.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> with TickerProviderStateMixin{
    late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final event = Provider.of<UserProvider>(context).Events;

    return Scaffold(
      drawer:Drawer(
        width: size.width*0.8,
        child: DrawerWidget(),
      ),
    appBar: AppBar(
              // leading: Icon(Icons.menu),
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
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
                child: Text("Total: ${event}", style: GoogleFonts.lato(
                  fontSize: size.height*0.014,
                  letterSpacing:1,
                   ),),
              )
              // 
            ],
          )
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(children: [
                Icon(Icons.event_sharp,
                size:size.height*0.014,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width*0.008
                  ),
                  child: Text("All Events", style: GoogleFonts.lato(
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
                  child: Text("Upcoming Events", style: GoogleFonts.lato(
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
                  child: Text("My Events", style: GoogleFonts.lato(
                    fontSize: size.height*0.014,
                  ),),
                ),
              ]),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AllEventsScreen(),
          UpcomingEventsScreen(),
          Center(child: Text('To display all attended events ')),
        ],
      ),
    );
  }
}