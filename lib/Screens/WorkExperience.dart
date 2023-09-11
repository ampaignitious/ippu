import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/WorkExperienceWidgets/SIngleWorkingExperienceDisplayScreen.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
   @override
    late Future<List<WorkingExperience>> WorkingExperienceFuture;

  @override
  void initState() {
    super.initState();
    WorkingExperienceFuture = fetchWorkingExperience();
 
  }
  // 
  Future<List<WorkingExperience>> fetchWorkingExperience() async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;
  final userId = userData?.id;
  // Define the URL with userData.id
  final apiUrl = 'http://app.ippu.or.ug/api/work-experience/$userId';

  // Define the headers with the bearer token
  final headers = {
    'Authorization': 'Bearer ${userData?.token}',
  };

  try {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> availableExperience = jsonData['data'];
      print(availableExperience);
      List<WorkingExperience> Experience = availableExperience.map((item) {
        return WorkingExperience(
          id:item['id'].toString() ,
          title:item['title'],
          user_id:item['user_id'].toString(),
          description:item['description'],
          start_date: item['start_date'],
          end_date: item['end_date'],
          attachment: item['attachment'],
          field: item['field'],
          points: item['points'],
          position: item['position'],
          type: item['type']
        );
      }).toList();
      return Experience;
    } else {
      throw Exception('Failed to load events data');
    }
  } catch (error) {
    // Handle the error here, e.g., display an error message to the user
          print("There is an error ");
    print('Error: $error');
    return []; // Return an empty list or handle the error in your UI
  }
}

  // 
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(
        title: Text("Working Experience", style: GoogleFonts.lato(),),
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        elevation: 0,
      ) ,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        child: Icon(Icons.add),
        onPressed: (){

      }),
      body: Column(
        children: [
          Center(
            child: Container(
              height: size.height*0.80,
              width: size.width*0.9,
           
              child: FutureBuilder<List<WorkingExperience>>(
                future: WorkingExperienceFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Check your internet connection to load the data"),
                    );
                  } else if (snapshot.hasData) {
                    List<WorkingExperience> eventData  = snapshot.data!;
                    return ListView.builder(
                      itemCount: eventData .length,
                      itemBuilder: (context, index) {
                        WorkingExperience data = eventData [index];
                        return Column(
                          children: [
                            SizedBox(
                              height:size.height*0.012,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return SingleWorkingExperienceDisplayScreen(
                              id: data.id.toString(),
                              title:data.title,
                              user_id:data.user_id.toString(),
                              description:data.description,
                              start_date: data.start_date,
                              end_date: data.end_date,
                              attachment: data.attachment,
                              field: data.field,
                              points: data.points,
                              position: data.position,
                              type: data.type
                                  );
                                }));
                              },
                              child: Container(
                                height: size.height*0.26,
                                width: size.width*0.84,
                                decoration: BoxDecoration(
                                   color: Colors.white,
                                  border: Border.all(
                                    
                                    color: Color.fromARGB(255, 210, 211, 211),
                                  ),
                                                     
                                  boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(0.8, 1.0),
                                  blurRadius: 4.0,
                                  spreadRadius: 0.2,
                                ),
                              ],
                                 ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(),
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                      padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.004),
                                      child: Text("Job Title", style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.height*0.028,
                                      ),),
                                ),
                                  Padding(
                                  padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.0008),
                                  child: Text("${data.title}", style: TextStyle(
                                    color: Colors.blue
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
                                    child: Text("Position", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.justify ,),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.06, right:size.width*0.06, top: size.height*0.0016),
                                    child: Text("${data.position}", textAlign: TextAlign.justify, style: TextStyle(
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
                                                      Divider(), 
                                                      // 
                                                      Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                      padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.004),
                                      child: Text("Description", style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.height*0.022,
                                      ),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: size.width * 0.06, top: size.height * 0.0008),
                                  child: Text(
                                      "${truncateDescription(data.description.toString(), 3)}",
                                      style: TextStyle(
                                      color: Colors.black,
                                      fontSize: size.height * 0.016,
                                    ),
                                  ),
                                )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right:size.width*0.006),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.read_more),
                                        Text("read more", style: TextStyle(
                                          fontSize: size.height*0.012,
                                        ),)
                                      ],
                                    ),
                                  )
                                  ],
                                 ),
                                                  // 
                                   
                                ],
                                ),
                              ),
                            ),
                            SizedBox(height:size.height*0.016),
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
                              SizedBox(
            
                            height: size.height*0.029,
                      ),
        
        ],
      ),
    );
  }
  // 
  String truncateDescription(String description, int wordCount) {
  List<String> words = description.split(' ');
  
  if (words.length <= wordCount) {
    return description;
  } else {
    // Take the first 'wordCount' words and join them with a space.
    return words.take(wordCount).join(' ') + '......';
  }
}
  // 
}
 
class WorkingExperience {
  final String? id;
  final String? user_id;
  final String? title;
  final String? description;
  final String? start_date;
  final String? end_date;
  final String? attachment;
  final String? field;
  final String? points;
  final String? position;
  final String? type;

  WorkingExperience({
    this.id,
    this.user_id,
    this.title,
    this.description,
    this.start_date,
    this.end_date,
    this.attachment,
    this.field,
    this.points,
    this.position,
    this.type,
  });
}