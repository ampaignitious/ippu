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
        cpdDataFuture=fetchdata();
 
  }
Future<List<CpdModel>> fetchdata() async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;

  if (userData == null || userData.id == null || userData.token == null) {
    // Handle the case where userData or its properties are null
    return [];
  }

  final apiUrl = 'https://ippu.org/api/upcoming-cpds/${userData.id}';

  final headers = {
    'Authorization': 'Bearer ${userData.token}',
  };

  try {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['data'];
      List<CpdModel> eventsData = data.map((item) {
        return CpdModel(
          attendance_request: item['attendance_request'],
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
              future: cpdDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Check your internet connection to load the data"),
                  );
                } else if (snapshot.hasData) {
                  // List<CpdModel>  data  = snapshot.data!;
                  final data = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:  data! .length,
                    itemBuilder: (context, index) {
                      // totalNumberOfAttendedCpds(int attended)
                        final userData = Provider.of<UserProvider>(context, listen: false).totalNumberOfAttendedCpds(data.length);
                      // CpdModel data =  data [index];
                      final item = data[index];
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
                      return Row(
                        children: [
                          InkWell(
                            onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context){
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
                          }));
                            },
                            child: Container(
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
                                  image: DecorationImage(image: NetworkImage("https:ippu.org/storage/banners/${item.banner}")),
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
                                child: Text("${item.topic}", style: TextStyle(
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
                          ),
                     SizedBox(
          
                          width: size.height*0.024,
                    ),
                        ],
                      );
                    },
                  );
                } else if(snapshot == null){
                  return Center(child: Text('No data available'));
                }else{
                  return Center(child: Text('No data available'));
                }
              },
            );
          
  }
}
