import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ippu/Widgets/EducationBackgroundWidgets/ContainerDisplayingUserEducationDetails.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class EducationBackgroundScreen extends StatefulWidget {
  const EducationBackgroundScreen({super.key});

  @override
  State<EducationBackgroundScreen> createState() => _EducationBackgroundScreenState();
}

class _EducationBackgroundScreenState extends State<EducationBackgroundScreen> {
TextEditingController _title = TextEditingController();
TextEditingController _type = TextEditingController();
TextEditingController _startDate = TextEditingController();
TextEditingController _endDate = TextEditingController();
TextEditingController _points = TextEditingController();
TextEditingController _field = TextEditingController();
TextEditingController _userId = TextEditingController();


  @override

  // 
  Future<void> addEducationBackground({
  required String title,
  required String type,
  required String startDate,
  required String endDate,
  required String points,
  required String field,
  required int id,
}) async {
  final String apiUrl = 'http://app.ippu.or.ug/api/education-background';

  final Map<String, dynamic> requestData = {
    "title": title,
    "type": type,
    "start_date": startDate,
    "end_date": endDate,
    "points": points,
    "field":field,
    "user_id": id,
  };
print(requestData);
  final response = await http.post(
    Uri.parse(apiUrl),
    body: json.encode(requestData),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    // Education background added successfully
    print(response.body);
    print('Education background added successfully');
    showBottomNotification('education background added successfully');
      Navigator.push(context, MaterialPageRoute(builder: (context){
      return EducationBackgroundScreen();
    }));
    
  } else {
    // Error handling for the failed request
    print('Failed to add education background: ${response.statusCode}');
  }
}
  // 
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        elevation: 0,
        title: Text("Education Background",style:GoogleFonts.lato()),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        onPressed: _showAddEducationDialog,
        tooltip: 'Add Education',
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height*0.009,
          ),
          Container(
            height: size.height*0.86,
            width: double.maxFinite,
            child: ContainerDisplayingUserEducationDetails()),
        ],
      ),
    );
  }



// 

  void _showAddEducationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final userData = Provider.of<UserProvider>(context).user;
        return AlertDialog(
          title: Text('Add New Background'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Institute Name'),
                  controller: _title,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Field of Study'),
                  controller: _field,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Course Name'),
                  controller: _type,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Points Scored'),
                  controller: _points,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Start Date'),
                  controller: _startDate,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'End Date'),
                  controller: _endDate,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save education details and close dialog
               addEducationBackground( 
               title: _title.text,
               field: _field.text,
                type: _type.text,
                startDate: _startDate.text,
                endDate: _endDate.text,
                points: _points.text,
                id: userData!.id,
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
// 
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