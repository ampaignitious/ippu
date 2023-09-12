import 'package:flutter/material.dart';
import 'package:ippu/models/EducationData.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';


class ContainerDisplayingUserEducationDetails extends StatefulWidget {
  const ContainerDisplayingUserEducationDetails({super.key});

  @override
  State<ContainerDisplayingUserEducationDetails> createState() => _ContainerDisplayingUserEducationDetailsState();
}

class _ContainerDisplayingUserEducationDetailsState extends State<ContainerDisplayingUserEducationDetails> {
  @override

  // 
      late Future<List<EducationData>> eventDataFuture;

  @override
  void initState() {
    super.initState();
    eventDataFuture = fetchEducationData();
 
  }
  Future<List<EducationData>> fetchEducationData() async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;

  // Define the URL with userData.id
  final apiUrl = 'http://app.ippu.or.ug/api/education-background/${userData?.id}';

  // Define the headers with the bearer token
  final headers = {
    'Authorization': 'Bearer ${userData?.token}',
  };

  try {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> eventData = jsonData['data'];
      List<EducationData> eventsData = eventData.map((item) {
        return EducationData(
          id :item['id'].toString(),
          userId: item['userId'].toString(),
          title: item['title'],
          description : item['description'],
          startDate : item['start_date'],
          endDate : item['end_date'],
          attachment : item['attachment'],
          field : item['field'],
          points : item['points'].toString(),
          position : item['position'],
          type :item['type']
          // 
        );
      }).toList();
      return eventsData;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Divider(),
          Center(
            child: Container(
              height: size.height*0.78,
              width: size.width * 0.85,
              child: FutureBuilder<List<EducationData>>(
                future: eventDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Check your internet connection to load the data"),
                    );
                  } else if (snapshot.hasData) {
                    List<EducationData> eventData  = snapshot.data!;
                    return ListView.builder(
                      itemCount: eventData .length,
                      itemBuilder: (context, index) {
                        EducationData data = eventData [index];
                        return Column(
                          children: [
                            Container(
                                height: size.height * 0.22,
                                width: size.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 42, 129, 201),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: Offset(0.8, 1.0),
                                      blurRadius: 4.0,
                                      spreadRadius: 0.2,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: size.height * 0.008),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                left: size.width * 0.03),
                                                child: Icon(Icons.school,
                                                color: Colors.white,
                                                ),
                                              )
          ,                                        Padding(
                                                padding: EdgeInsets.only(
                                                    left: size.width * 0.03),
                                                child: Text(
                                                  "${data.title}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: size.height * 0.014,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: size.width * 0.03),
                                            child: Text(
                                              "Points: ${data.points}", style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.white,
                                      ),
                                      Padding(
                                       padding: EdgeInsets.only(
                                                left: size.width * 0.03),
                                        child: Text("Field: ${data.field}", style:TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ) ,),
                                      ),
                                      Padding(
                                       padding: EdgeInsets.all(
                                                  size.width * 0.03),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text("Start date: ${data.startDate}", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.height * 0.012,
                                            ),),
                                            Text("End date: ${data.endDate}", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.height * 0.012,
                                              
                                            ),)
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.white,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.edit,
                                          color: Colors.white,
                                          ),
                                          Icon(Icons.delete,
                                          color: Colors.amber[200],
                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            SizedBox(height: size.height * 0.014),

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
          ),
        ],
      ),
    );
  }
}
