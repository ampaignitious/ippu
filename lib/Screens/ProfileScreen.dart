
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Providers/SubscriptionStatus.dart';
import 'package:ippu/Widgets/DrawerWidget/DrawerWidget.dart';
import 'package:ippu/Widgets/ProfileWidgets/EditProfile.dart';
import 'package:ippu/Widgets/ProfileWidgets/InformationScreen.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController _profileController;
  // late List<ProfileData> profileDataList = [];

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String? status= context.watch<SubscriptionStatusProvider>().status;
    return Scaffold(
      drawer: Drawer(
        width: size.width * 0.8,
        child: const DrawerWidget(),
      ),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 42, 129, 201),
        elevation: 0,
        actions: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: EdgeInsets.only(right: size.width * 0.016),
                child:Text(
                        (status=="false")?"No Subscription":"Subscription:$status",
                        style: GoogleFonts.lato(
                          fontSize: size.height * 0.020,
                          color: (status=="Pending")?Colors.yellowAccent:(status=="Approved")?Colors.green:(status=="Denied")?Colors.red:Colors.white,
                        fontWeight: FontWeight.bold
                        ),
                      )
                    ),
          ])
        ],
        bottom: TabBar(
          controller: _profileController,
          tabs: const [
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
                SizedBox(height: size.height * 0.012),
                status == 'false'
                    ? InkWell(
                        onTap: () {
                          sendRequest();
                        },
                        child: Center(
                          child: Container(
                            height: size.height * 0.06,
                            width: size.width * 0.95,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 42, 129, 201),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                      0.2), // Adjust shadow color and opacity
                                  offset: const Offset(
                                      0.8, 1.0), // Adjust the shadow offset
                                  blurRadius: 4.0, // Adjust the blur radius
                                  spreadRadius: 0.2, // Adjust the spread radius
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.015,
                                        left: size.width * 0.034),
                                    child: Text(
                                      "Click here to subscribe",
                                      style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: size.height * 0.018,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //
                          ),
                        ),
                      )
                    : Text(''),
                SizedBox(
                    height: size.height * 0.9,
                    width: double.maxFinite,
                    child: InformationScreen()),
              ],
            ),
          ),

          // Edit Profile Tab Content
          const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Add content for Edit Profile tab here
                EditProfile()
                // EditUserProfile()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendRequest() async {
    AuthController authController = AuthController();

    //try catch
    try {
      final response = await authController.subscribe();
      //check if response contains message key
      if (response.containsKey("message")) {
        //notify the SubscriptionStatusProvider
        if(mounted){
        context.read<SubscriptionStatusProvider>().setSubscriptionStatus("Pending");
        }
        //show bottom notification
        showBottomNotification("your request has been sent! You will be approved");
      } else {
        //show bottom notification
        showBottomNotification("Something went wrong");
      }
    } catch (e) {
      print(e);
      showBottomNotification("Something went wrong");
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
