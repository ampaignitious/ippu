import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ippu/Screens/ProfileScreen.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/FirstSetOfRows.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/StatDisplayRow.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/StatusDisplayContainers/allCommunication.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/StatusDisplayContainers/allCpdDisplay.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/StatusDisplayContainers/allEventDisplay.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/StatusDisplayContainers/availableJob.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/StatusDisplayContainers/userAppGuide.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:ippu/models/CpdModel.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class FirstDisplaySection extends StatefulWidget {
  const FirstDisplaySection({super.key});

  @override
  State<FirstDisplaySection> createState() => _FirstDisplaySectionState();
}

class _FirstDisplaySectionState extends State<FirstDisplaySection> {
  @override
  int totalCPDS = 0;
  int totalEvents = 0;
  int totalCommunications = 0;
  late String totaleventPoints;

  late Future<List<CpdModel>> cpdDataFuture;
  late List<CpdModel> fetchedData = [];

  bool isProfileIncomplete = true;
    bool isSubscription = true;

  @override
  void initState() {
    super.initState();
  Timer(Duration(seconds: 10), () {
    setState(() {
      isSubscription = false;
    });
  });
    fetchData();

    cpdDataFuture = fetchAllCpds();
    cpdDataFuture = fetchAllCpds().then((data) {
      fetchedData = data;
      return data;
    });
    cpdDataFuture = fetchAllCpds();
  }
// function for fetching cpds 
  Future<List<CpdModel>> fetchAllCpds() async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;

  // Define the URL with userData.id
  final apiUrl = 'https://ippu.org/api/cpds/${userData?.id}';

  // Define the headers with the bearer token
  final headers = {
    'Authorization': 'Bearer ${userData?.token}',
  };

  try {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> eventData = jsonData['data'];
      List<CpdModel> cpdData = eventData.map((item) {
        return CpdModel(
          // 
          id:item['id'].toString(),
          code:item['code'],
          topic: item['topic'],
          content: item['content'],
          hours: item['hours'],
          points: item['points'],
          targetGroup:item['target_group'],
          location:item['location'],
          startDate:item['start_date'],
          endDate:item['end_date'],
          normalRate:item['normal_rate'],
          membersRate:item['members_rate'],
          resource:item['resource'],
          status:item['status'],
          type:item['type'],
          banner:item['banner'],
          attendance_request:item['attendance_request']
          // 
        );
      }).toList();
      print(cpdData);
      return cpdData;
    } else {
      throw Exception('Failed to load events data');
    }
  } catch (error) {
    // Handle the error here, e.g., display an error message to the user
    print('Error: $error');
    return []; // Return an empty list or handle the error in your UI
  }
}
// 
  Future<void> fetchData() async {
    try {
      AuthController authController = AuthController();
      final cpds = await authController.getCpds();
      final events = await authController.getEvents();
      final communications = await authController.getAllCommunications();
      final eventPoints = await authController.getEvents();
      int totalCPDS = cpds.length;
      int totalEventPoints = 0; // Initialize the total event points
      int totalCpdPoints =0;
    // Calculate total event points

    // 
 
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
// function for fetching cpds 
// 
    // 

      setState(() {
        totalEvents = events.length;
        totalCommunications = communications.length;
        Provider.of<UserProvider>(context, listen: false).totalNumberOfCPDS(totalCPDS);
        Provider.of<UserProvider>(context, listen: false).totalNumberOfEvents(totalEvents);
        Provider.of<UserProvider>(context, listen:false).totalNumberOfCommunications(totalCommunications);
      });
    } catch (e) {
      // Handle any errors here
      print('Error fetching data: $e');
    }
  }

  // // 
  Widget build(BuildContext context) {
        final userData = Provider.of<UserProvider>(context).user;
      final status  =    Provider.of<UserProvider>(context, listen: false).getSubscriptionStatus;
        void completeProfile(){
          if(userData!.nok_address == null){
            showBottomNotification("Please complete your profile");
          }
        }
      final size = MediaQuery.of(context).size;
      final cpds = Provider.of<UserProvider>(context).CPDS;
      final event = Provider.of<UserProvider>(context).Events;
      final communications = Provider.of<UserProvider>(context).totalCommunications;

    return Stack(
      children: [
        Container(
          height: size.height * 0.35,
          width: size.width * 1,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 42, 129, 201),
          ),
          child: Column(
            children: [
              Text(
                "Welcome to IPPU mobile applications",
                style: TextStyle(color: Colors.white, fontSize: size.height * 0.016),
              ),
              SizedBox(height: size.height * 0.026),
              StatDisplayRow(),
            ],
          ),
        ),
        // bottom colored container
        Container(
          margin: EdgeInsets.only(top: size.height * 0.24, left: size.width * 0.032),
          height: size.height * 0.56,
          width: size.width * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.018),
                FirstSetOfRows(),
                SizedBox(height: size.height * 0.002),
                // 
                allCpdDisplay(),
                // 
                SizedBox(height: size.height * 0.024),
                // 
                allEventDisplay(),
                // 
                SizedBox(height: size.height * 0.024),

                // 
                allCommunication(),
                // 

                SizedBox(height: size.height * 0.024),

                availableJob(),
                // 
                 SizedBox(height: size.height * 0.024),

                 userAppGuide(),
                // 
                
              // 
              ],
            ),
          ),
        ),
        // container displaying the notifcation
             userData!.gender == null
        ? Center(
            child: isProfileIncomplete
                ? Container(
                    height: size.height * 0.08,
                    width: size.width * 0.95,
                    margin: EdgeInsets.only(bottom: size.height * 0.004),
                 decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color:Colors.white,
                    ),
                    color: Color.fromARGB(255, 42, 129, 201),
                    boxShadow: [
                      BoxShadow(
                      color: Color.fromARGB(255, 247, 245, 245) , // Adjust shadow color and opacity
                      offset: Offset(0.8, 0.8), // Adjust the shadow offset
                      blurRadius: 4.0, // Adjust the blur radius
                      spreadRadius: 0.2, // Adjust the spread radius
                          ),
                        ],
                  ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ProfileScreen();
                              }));
                            },
                            child: Center(
                              child: Text(
                                "Please Complete your profile",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isProfileIncomplete = false;
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          )
        : Text(""),
// displaying subscription status
        status == null
        ?  Text("") :Center(
            child: isSubscription
                ? Container(
                    height: size.height * 0.08,
                    width: size.width * 0.95,
                    margin: EdgeInsets.only(bottom: size.height * 0.004),
                 decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color:Colors.white,
                    ),
                    color: Color.fromARGB(255, 42, 129, 201),
                    boxShadow: [
                      BoxShadow(
                      color: Color.fromARGB(255, 247, 245, 245) , // Adjust shadow color and opacity
                      offset: Offset(0.8, 0.8), // Adjust the shadow offset
                      blurRadius: 4.0, // Adjust the blur radius
                      spreadRadius: 0.2, // Adjust the spread radius
                          ),
                        ],
                  ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ProfileScreen();
                              }));
                            },
                            child: Center(
                              child: Text(
                                "Subscription status: ${status}",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  // decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSubscription = false;
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          )
          // 
        ,
      ],
    );
  }
  // 
void showBottomNotification(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}
  // 
}
