import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/CpdsSingleEventDisplay.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/AttendedSingleCpdDisplay.dart';
import 'package:ippu/models/CpdModel.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class attendedCpdListHorizontalView extends StatefulWidget {
  const attendedCpdListHorizontalView({super.key});

  @override
  State<attendedCpdListHorizontalView> createState() => _attendedCpdListHorizontalViewState();
}

class _attendedCpdListHorizontalViewState extends State<attendedCpdListHorizontalView> {
  
  
 late Future<List<CpdModel>> cpdDataFuture;
   void initState() {
    super.initState();
        cpdDataFuture=fetchUpcomingCpds();
 
  }
 // function for fetching cpds 
  Future<List<CpdModel>> fetchUpcomingCpds() async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;

  // Define the URL with userData.id
  final apiUrl = 'https://ippu.org/api/upcoming-cpds/${userData?.id}';

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
    return FutureBuilder<List<CpdModel>>(
              future: cpdDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child:  Text('No data available, Or check internet connection'));
                } else {
                  final data = snapshot.data;
                  if (data != null) {
                    return ListView.builder(
                      // controller: _scrollController,
                      // scrollDirection: Axis.horizontal,
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
                                    imagelink: 'https://ippu.org/storage/banners/${imageLink}',
                                    cpdsname: activityName,
                                  );
                                }),
                              );
                            },
                        child: Container(
                                height: size.height * 0.35,
                                width: size.width * 0.85,
                          child: Column(
                            children: [
                              Text("Upcoming Cpds",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 42, 129, 201),
                              ),
                              ),
                              SizedBox(height: size.height*0.010,),
                              Container(
                                margin: EdgeInsets.only(
                                  right: size.height * 0.009,
                                  left: size.height * 0.009,
                                ),
                                height: size.height * 0.28,
                                width: size.width * 0.62,
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
                                    image: NetworkImage('https://ippu.org/storage/banners/${imageLink}'),
                                  ),
                                ),
                              ),
                              Text("Click to read more",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height*0.015,
                                color: Color.fromARGB(255, 42, 129, 201),
                              )),
                            ],
                          ),
                        ),
                          );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              },
            );          
  }
}
