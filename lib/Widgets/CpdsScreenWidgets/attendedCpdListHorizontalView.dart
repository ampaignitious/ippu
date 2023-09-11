import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/AttendedSingleCpdDisplay.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class attendedCpdListHorizontalView extends StatefulWidget {
  const attendedCpdListHorizontalView({super.key});

  @override
  State<attendedCpdListHorizontalView> createState() => _attendedCpdListHorizontalViewState();
}

class _attendedCpdListHorizontalViewState extends State<attendedCpdListHorizontalView> {
  

    late Future<List<CpdModel>> CpdDataFuture;
   void initState() {
    super.initState();
    CpdDataFuture =   fetchCpdData();
 
  }
Future<List<CpdModel>> fetchCpdData() async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;

  if (userData == null || userData.id == null || userData.token == null) {
    // Handle the case where userData or its properties are null
    return [];
  }

  final apiUrl = 'http://app.ippu.or.ug/api/attended-cpds/${userData.id}';

  final headers = {
    'Authorization': 'Bearer ${userData.token}',
  };

  try {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> CpdData = jsonData['data'];
      List<CpdModel> eventsData = CpdData.map((item) {
        return CpdModel(
          id: item['id'].toString(),
          code: item['code'],
          topic: item['topic'],
          content: item['content'],
          hours: item['hours'],
          points: item['points'],
          targetGroup: item['target_group'], // Use correct key name
          location: item['location'],
          startDate: item['start_date'], // Use correct key name
          endDate: item['end_date'], // Use correct key name
          normalRate: item['normal_rate'], // Use correct key name
          membersRate: item['members_rate'], // Use correct key name
          resource: item['resource'],
          status: item['status'],
          type: item['type'],
          banner: item['banner'],
        );
      }).toList();
      return eventsData;
    } else {
      throw Exception('Failed to load events data');
    }
  } catch (error) {
    print('Error: $error');
    return [];
  }
}

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder<List<CpdModel>>(
              future: CpdDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Check your internet connection to load the data"),
                  );
                } else if (snapshot.hasData) {
                  List<CpdModel>  CpdData  = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:  CpdData .length,
                    itemBuilder: (context, index) {
                      // totalNumberOfAttendedCpds(int attended)
                        final userData = Provider.of<UserProvider>(context, listen: false).totalNumberOfAttendedCpds(CpdData.length);
                      CpdModel data =  CpdData [index];
                      return Row(
                        children: [
                          Container(
                            height: size.height*0.3,
                            width: size.width*0.64,
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
                             ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Center(
                                child: Container(
                                  height: size.height*0.22,
                                                width: size.width*0.56,
                                                decoration: BoxDecoration(
                                // border: Border.all(
                                //   color: Colors.lightBlue,
                                // ),
                                image: DecorationImage(image: NetworkImage("http://app.ippu.or.ug/storage/banners/${data.banner}")),
                                                ),
                                ),
                              ),
                              Divider(),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                  padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.004),
                                  child: Text("Event name", style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height*0.008,
                                  ),),
                            ),
                              Padding(
                              padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.0008),
                              child: Text("${data.topic }", style: TextStyle(
                                color: Colors.blue,
                                fontSize: size.height*0.008,
                              ),),
                            ),
                                ],
                              )
                             
                              ],
                             )
                            
                      ],
                            ),
                          ),
                     SizedBox(
          
                          width: size.height*0.024,
                    ),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            );
          
  }
}
class CpdModel {
  final String id;
  final String code;
  final String topic;
  final String content;
  final String hours;
  final String points;
  final String targetGroup;
  final String location;
  final String startDate;
  final String endDate;
  final String normalRate;
  final String membersRate;
  final String resource;
  final String status;
  final String type;
  final String banner;

  CpdModel({
    required this.id,
    required this.code,
    required this.topic,
    required this.content,
    required this.hours,
    required this.points,
    required this.targetGroup,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.normalRate,
    required this.membersRate,
    required this.resource,
    required this.status,
    required this.type,
    required this.banner,
  });
}