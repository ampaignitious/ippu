import 'package:flutter/material.dart';
import 'package:ippu/Screens/SettingsScreen.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/ProfileWidgets/EditProfile.dart';
import 'package:ippu/Widgets/ProfileWidgets/InfoScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController _profileController;

  @override
  void initState() {
    super.initState();
    _profileController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _profileController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        width: size.width * 0.8,
        child: DrawerWidget(),
      ),
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return SettingsScreen();
              }));
            },
          ),
        ],
        bottom: TabBar(
          controller: _profileController,
          tabs: [
            Tab(text: 'Bio data'),
            Tab(text: 'Edit Profile'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _profileController,
        children: [

          // Info Tab Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add content for Info tab here
                InfoScreen(),
                
                
              ],
            ),
          ),

          // Edit Profile Tab Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Add content for Edit Profile tab here
                EditProfile()
              ],
            ),
          ),

        ],
      ),
    );
  }
}
