import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/CpdsSingleEventDisplay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
 import 'package:ippu/models/CpdModel.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';


class ContainerDisplayingUpcomingCpds extends StatefulWidget {
  const ContainerDisplayingUpcomingCpds({super.key});

  @override
  State<ContainerDisplayingUpcomingCpds> createState() => _ContainerDisplayingUpcomingCpdsState();
}

class _ContainerDisplayingUpcomingCpdsState extends State<ContainerDisplayingUpcomingCpds> with TickerProviderStateMixin {
 

  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  bool _showBackToTopButton = false;

  late Future<List<CpdModel>> cpdDataFuture;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollVisibility);
    cpdDataFuture=fetchUpcomingCpds();
  }

  void _updateScrollVisibility() {
    setState(() {
      _showBackToTopButton = _scrollController.offset > _scrollController.position.maxScrollExtent / 2;
      
    });
  }

  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
 // function for fetching cpds 
  Future<List<CpdModel>> fetchUpcomingCpds() async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;

  // Define the URL with userData.id
  final apiUrl = 'http://app.ippu.or.ug/api/upcoming-cpds/${userData?.id}';

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

  Widget build(BuildContext context) {
final size = MediaQuery.of(context).size;
   return Scaffold(
    floatingActionButton: Visibility(
        visible: _showBackToTopButton,
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 42, 129, 201),
          onPressed: _scrollToTop,
          child: Icon(
            Icons.arrow_upward,
            color: Colors.white,
          ),
          shape: CircleBorder(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.height * 0.020),
            child: Text(
              "( Scroll to see more CPDS and click on the CPD to see more details )",
              style: GoogleFonts.lato(
                fontSize: size.height * 0.012,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: FutureBuilder<List<CpdModel>>(
              future: cpdDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No data available');
                } else {
                  final data = snapshot.data;
                  if (data != null) {
                    return ListView.builder(
                      // controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                         // Ensure the properties accessed here match the structure of your API response
                        final imagelink = 'assets/cpds0.jpg';
                        final activityName = item.topic;
                        final points = item.points;
                        final startDate =item.startDate;
                        final endDate =item.endDate;
                        final content = item.content;
                        final attendance_request = item.attendance_request;
                        final rate = item.normalRate;
                        final location = item.location;
                        final type = item.type;
                        final imageLink = item.banner;
                        final target_group = item.targetGroup;
                        final cpdId = item.id.toString();

                        if (_searchQuery.isEmpty ||
                            activityName
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              print('${item}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return CpdsSingleEventDisplay(
                                    attendance_request: attendance_request ,
                                    content: content,
                                    target_group: target_group,
                                    startDate: startDate,
                                    endDate: endDate,
                                    rate: location.toString(),
                                    type: type,
                                    cpdId:cpdId.toString(),
                                    location: rate,
                                    attendees: points,
                                    imagelink: 'http://app.ippu.or.ug/storage/banners/${imageLink}',
                                    cpdsname: activityName,
                                  );
                                }),
                              );
                            },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                right: size.height * 0.009,
                                left: size.height * 0.009,
                              ),
                              height: size.height * 0.35,
                              width: size.width * 0.85,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(0.8, 1.0),
                                blurRadius: 4.0,
                                spreadRadius: 0.2,
                              ),
                            ],
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)
                                ),
                                image: DecorationImage(
                                  image: NetworkImage('http://app.ippu.or.ug/storage/banners/${imageLink}'),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.012),

                            Container(
                          height: size.height * 0.089,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 42, 129, 201),
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: size.height * 0.008),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: size.width * 0.03),
                                      child: Text(
                                        "${item.topic.split(' ').take(4).join(' ')}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.height * 0.014,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: size.width * 0.03),
                                      child: Icon(
                                        Icons.read_more,
                                        size: size.height * 0.02,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_month,
                                              size: size.height * 0.02,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "Start Date",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${item.startDate}",
                                          style: TextStyle(fontSize: size.height * 0.008, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Rate", style: TextStyle(color: Colors.white)),
                                        Text(
                                          "${item.type}",
                                          style: TextStyle(fontSize: size.height * 0.008, color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.018),
                      
                              ],
                            ),
                          );
                        } else {
                          return Container(); // Return an empty container for non-matching items
                        }
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              },
            ),
          )
       ],
      ),
   );
  }
}