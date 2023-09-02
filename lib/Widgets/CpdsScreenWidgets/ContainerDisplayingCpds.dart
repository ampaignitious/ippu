import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/CpdsSingleEventDisplay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ippu/controllers/auth_controller.dart';

class ContainerDisplayingCpds extends StatefulWidget {
  const ContainerDisplayingCpds({super.key});

  @override
  State<ContainerDisplayingCpds> createState() =>
      _ContainerDisplayingCpdsState();
}

class _ContainerDisplayingCpdsState extends State<ContainerDisplayingCpds>
    with TickerProviderStateMixin {
  AuthController authController = AuthController();

  List images = [
    "cpds1.jpg",
    "cpds2.jpg",
    "cpds3.jpg",
    "cpds4.jpg",
    "cpds3.jpg",
    "cpds2.jpg",
    "cpds4.jpg",
  ];
  List activityname = [
    "Contract Management",
    "Integration and implementation",
    "Sustainable Procurement",
    "Free CPD For all",
    "Test ver 2",
  ];
  List attendees = [
    "20",
    "5",
    "100",
    "2",
    "1",
  ];

  final ScrollController _scrollController = ScrollController();

  Future<void> fetchData({required String token}) async {
    final response = await http.get(
      Uri.parse('http://app.ippu.or.ug/api/cpds'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print("${token}");
    print(response.body); // Print the response body to the console

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data); // Print the parsed JSON data to the console
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollVisibility);
  }

  void _updateScrollVisibility() {
    setState(() {
      _showBackToTopButton = _scrollController.offset >
          _scrollController.position.maxScrollExtent / 2;
    });
  }

  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
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
            padding: EdgeInsets.only(
                left: size.height * 0.012,
                right: size.height * 0.012,
                top: size.height * 0.012),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: size.height * 0.004,
                    horizontal: size.width * 0.035),
                labelText: 'Search CPDS by name',
                labelStyle: GoogleFonts.lato(
                    fontSize: size.height * 0.022, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _searchQuery = _searchController.text;
                    });
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
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
            child: FutureBuilder<List<dynamic>>(
              future: authController.getCpds(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No data available');
                } else {
                  final data = snapshot.data;
                  if (data != null) {
                    return ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        // Ensure the properties accessed here match the structure of your API response
                        final imagelink = 'assets/cpds0.jpg';
                        final activityName = item['topic'];
                        final attendees = item['points'];

                        if (_searchQuery.isEmpty ||
                            activityName
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return CpdsSingleEventDisplay(
                                    attendees: attendees,
                                    imagelink: imagelink,
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
                                    image: DecorationImage(
                                      image: AssetImage(imagelink),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.014),
                                // Rest of your widget code for each item goes here
                                // ...
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
