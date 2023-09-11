import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/AttendedSingleCpdDisplay.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class AttendedCpdsScreen extends StatefulWidget {
  const AttendedCpdsScreen({super.key});

  @override
  State<AttendedCpdsScreen> createState() => _AttendedCpdsScreenState();
}

class _AttendedCpdsScreenState extends State<AttendedCpdsScreen> {
  
      late Future<List<CpdModel>> CpdDataFuture;
@override

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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
 
          Divider(),
          Container(
            height: size.height*0.70,
            width: double.maxFinite,
 
            child: FutureBuilder<List<CpdModel>>(
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
                    itemCount:  CpdData .length,
                    itemBuilder: (context, index) {
                      // totalNumberOfAttendedCpds(int attended)
                        final userData = Provider.of<UserProvider>(context, listen: false).totalNumberOfAttendedCpds(CpdData.length);
                      CpdModel data =  CpdData [index];
                      return Column(
                        children: [
                          Container(
                            height: size.height*0.46,
                            width: size.width*0.84,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.lightBlue,
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
                                    fontSize: size.height*0.04,
                                  ),),
                            ),
                              Padding(
                              padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.0008),
                              child: Text("${data.topic }", style: TextStyle(
                                color: Colors.blue,
                                fontSize: size.height*0.012,
                              ),),
                            ),
                                ],
                              ),
                            Padding(
                              padding: EdgeInsets.only(right: size.width*0.07),
                              child: Column(
                                children: [
                              Padding(
                               padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.016),
                                child: Text("Points", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.justify ,),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: size.width*0.06, right:size.width*0.06, top: size.height*0.0016),
                                child: Text("${data.points}", textAlign: TextAlign.justify, style: TextStyle(
                                  color: Colors.blue
                                ),),
                              ),
                                ],
                              ),
                            ),
                             
                              ],
                             ),
                    SizedBox(
          
                          height: size.height*0.024,
                    ),
                            
                    Center(
                          child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary:  Color.fromARGB(255, 42, 129, 201), // Change button color to green
                                      padding: EdgeInsets.all( size.height * 0.020),
                                
                                    ),
                                    onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                            return  AttendedSingleCpdDisplay(
                                content: data.content,
                                target_group: data.targetGroup,
                                startDate: data.startDate,
                                endDate: data.endDate,
                                type: data.type,
                                location: data.location,
                                imagelink: 'http://app.ippu.or.ug/storage/banners/${data.banner}',
                                cpdsname: data.topic,
                                      
                            );
                          }));
                                    },
                                    child: Text('Click to view more information', style: GoogleFonts.lato(),),
                          ),
                    ),
                               
                              ],
                            ),
                          ),
                          SizedBox(
          
                      height: size.height*0.024,
                    ),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
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