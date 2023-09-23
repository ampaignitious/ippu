import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Screens/SettingsScreen.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';
import 'package:ippu/Widgets/ProfileWidgets/EditProfile.dart';
 import 'package:ippu/Widgets/ProfileWidgets/InformationScreen.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
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
    final status  =    Provider.of<UserProvider>(context, listen: false).getSubscriptionStatus;

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
          // IconButton(
          //   icon: Icon(Icons.settings),
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context){
          //       return SettingsScreen();
          //     }));
          //   },
          // ),
          
          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              // top: size.height*0.008,
                              left: size.width*0.034),
                            child: Text("Subscription State: ",
                            style: GoogleFonts.lato(
                              color: Color.fromARGB(255, 15, 255, 23) ,
                              fontSize: size.height*0.018,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.width*0.016),
                            child: Text("${status}",
                            style: GoogleFonts.lato(
                              fontSize: size.height*0.015,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          ),
         ] )
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
                // InfoScreen(),
                
                Container(
                  height: size.height*0.9,
                  width: double.maxFinite,
                  child: InformationScreen()),  
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
  Future<void> sendRequest( ) async {
    final userData = Provider.of<UserProvider>(context, listen: false).user;
  final url = 'https://ippu.org/api/subscribe';

  // Create the request body
  final body = {
    'user_id': userData!.id.toString(),
    'auth_token': userData.token,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      body: body,
    );

    if (response.statusCode == 200) {
      // Successful response, return the response body as a message
      showBottomNotification('Application submitted successfully, check your email address');
      

    } else {
      // If the request was not successful, throw an exception
      throw Exception('Failed to send request: ${response.statusCode}');
    }
  } catch (error) {
    // Handle any errors that occurred during the request
    throw Exception('Failed to send request: $error');
  }
}
void showBottomNotification(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}
}
