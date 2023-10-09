import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:ippu/models/EducationData.dart';
import 'package:timeline_tile/timeline_tile.dart';

class EducationBackgroundScreen extends StatefulWidget {
  const EducationBackgroundScreen({super.key});

  @override
  State<EducationBackgroundScreen> createState() =>
      _EducationBackgroundScreenState();
}

class _EducationBackgroundScreenState extends State<EducationBackgroundScreen> {
  //to control the visibility of the form
  bool _isFormVisible = false;
  late Future<List<EducationData>> eventDataFuture;
  @override
  void initState() {
    super.initState();
    eventDataFuture = fetchEducationData();
  }

  //form fields
  TextEditingController _title = TextEditingController();
  TextEditingController _type = TextEditingController();
  TextEditingController _startDate = TextEditingController();
  TextEditingController _endDate = TextEditingController();
  TextEditingController _points = TextEditingController();
  TextEditingController _field = TextEditingController();
  TextEditingController _userId = TextEditingController();

  @override
  Future<void> addEducationBackground({
    required String title,
    String type = "",
    required String startDate,
    required String endDate,
    required String points,
    required String field,
    required int id,
  }) async {
    final String apiUrl = 'https://ippu.org/api/education-background';

    final Map<String, dynamic> requestData = {
      "title": title,
      "type": type,
      "start_date": startDate,
      "end_date": endDate,
      "points": points,
      "field": field,
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

      setState(() {
        eventDataFuture = fetchEducationData();
      });
    } else {
      // Error handling for the failed request
      print('Failed to add education background: ${response.statusCode}');
    }
  }

  //
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        elevation: 0,
        title: Text("Education Background", style: GoogleFonts.lato()),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 42, 129, 201),
        onPressed: _toggleFormVisibility,
        tooltip: 'Add Education',
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.009,
          ),
          // Conditionally render the content based on the _isFormVisible flag
          _isFormVisible ? _buildEducationForm() : _buildExistingContent(),
        ],
      ),
    );
  }

  //

  Widget _buildExistingContent() {
    // Fetch the education data from the API
    final educationData = fetchEducationData();
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Center(
          child: Container(
            height: size.height * 0.78,
            width: size.width * 0.85,
            child: FutureBuilder<List<EducationData>>(
              future: eventDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child:
                        Text("Check your internet connection to load the data"),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // return const Text('No data available');
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.14,
                        ),
                        Image(image: AssetImage('assets/no_data.png')),
                        Text("No education data available")
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  List<EducationData> eventData = snapshot.data!;
                  return ListView.builder(
                    itemCount: eventData.length,
                    itemBuilder: (context, index) {
                      final experience = eventData[index];
                      return SizedBox(
                        child: TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.1,
                          indicatorStyle: IndicatorStyle(
                            width: 20,
                            height: 20,
                            indicator:
                                _buildIndicator(), // You can customize your indicator here
                          ),
                          beforeLineStyle: const LineStyle(
                            color: Colors.grey,
                          ),
                          endChild: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.blue,
                            child: IntrinsicHeight(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${experience.title}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                        'Period: ${experience.startDate} to ${experience.endDate}',
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                    Text('Course: ${experience.field}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text('Points: ${experience.points}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // Update the selected date in the text field
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      controller.text = formattedDate;
    }
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

  void _toggleFormVisibility() {
    setState(() {
      _isFormVisible = !_isFormVisible;
    });
  }

  Widget _buildEducationForm() {
    final size = MediaQuery.of(context).size;
    final userData = Provider.of<UserProvider>(context).user;

    // Define border radius and border width for the input fields
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.grey, // Border color
        width: 1.0, // Border width
      ),
    );

    return Padding(
      padding: EdgeInsets.all(size.width * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            // Display the form title
            child: Text(
              'Add Education Background',
              style: TextStyle(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          TextField(
            decoration: InputDecoration(
              labelText: 'Institute Name',
              border: outlineInputBorder,
            ),
            controller: _title,
          ),
          SizedBox(height: size.height * 0.02),
          TextField(
            decoration: InputDecoration(
              labelText: 'Course Name',
              border: outlineInputBorder,
            ),
            controller: _field,
          ),
          SizedBox(height: size.height * 0.02),
          TextField(
            decoration: InputDecoration(
              labelText: 'Points Scored',
              border: outlineInputBorder,
            ),
            controller: _points,
          ),
          SizedBox(height: size.height * 0.02),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Start Date',
              border: outlineInputBorder,
            ),
            controller: _startDate,
            onTap: () => _selectDate(context, _startDate),
          ),
          SizedBox(height: size.height * 0.02),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'End Date',
              border: outlineInputBorder,
            ),
            controller: _endDate,
            onTap: () => _selectDate(context, _endDate),
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Clear form fields and hide the form
                  _clearForm();
                  _toggleFormVisibility();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Save education details and close the form
                  addEducationBackground(
                    title: _title.text,
                    field: _field.text,
                    startDate: _startDate.text,
                    endDate: _endDate.text,
                    points: _points.text,
                    id: userData!.id,
                  );
                  _clearForm();
                  _toggleFormVisibility();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    // Clear form fields when the form is closed or submitted
    _title.clear();
    _field.clear();
    _type.clear();
    _points.clear();
    _startDate.clear();
    _endDate.clear();
  }

  Future<List<EducationData>> fetchEducationData() async {
    final userData = Provider.of<UserProvider>(context, listen: false).user;

    // Define the URL with userData.id
    final apiUrl = 'https://ippu.org/api/education-background/${userData?.id}';

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
            id: item['id'].toString(),
            userId: item['userId'].toString(),
            title: item['title'],
            description: item['description'],
            startDate: item['start_date'],
            endDate: item['end_date'],
            attachment: item['attachment'],
            field: item['field'],
            points: item['points'].toString(),
            position: item['position'],
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

  Widget _buildIndicator() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue, // You can change indicator color here
      ),
    );
  }
}
