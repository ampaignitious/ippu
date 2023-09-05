import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/CpdsSingleEventDisplay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ippu/controllers/auth_controller.dart';

class ContainerDisplayingCpds extends StatefulWidget {
  const ContainerDisplayingCpds({super.key});

  @override
  State<ContainerDisplayingCpds> createState() => _ContainerDisplayingCpdsState();
}

class _ContainerDisplayingCpdsState extends State<ContainerDisplayingCpds> with TickerProviderStateMixin {
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
 
 
  void _scrollToTop() {
    _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  bool _showBackToTopButton = false;

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
 AuthController authController = AuthController();

  @override
void initState() {
  super.initState();
  _scrollController.addListener(_updateScrollVisibility);
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
            padding: EdgeInsets.only(left:size.height * 0.012, right: size.height * 0.012, top: size.height * 0.012),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: size.height*0.004, horizontal: size.width*0.035),
                labelText: 'Search CPDS by name',
                labelStyle: GoogleFonts.lato(
                  fontSize: size.height*0.022,
                  color: Colors.grey),
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
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                if (_searchQuery.isEmpty || activityname[index].toLowerCase().contains(_searchQuery.toLowerCase())) {
                  return InkWell(
                    // onTap: () {
                     
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) {
                    //       return CpdsSingleEventDisplay(
                    //         attendees: attendees[index],
                    //         imagelink: 'assets/cpds${index}.jpg',
                    //         cpdsname: activityname[index],
                    //       );
                    //     }),
                    //   );
                    // },
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: size.height * 0.009, left: size.height * 0.009),
                          height: size.height * 0.35,
                          width: size.width * 0.85,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/cpds${index}.jpg")),
                          ),
                        ),
                        SizedBox(height: size.height * 0.014),
                        Container(
                          height: size.height * 0.089,
                          width: size.width * 0.7,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: size.width * 0.03),
                                      child: Text(
                                        "${activityname[index]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.height * 0.018,
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
                                          "July 4, 2023, 12:00 am",
                                          style: TextStyle(fontSize: size.height * 0.008, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Rate", style: TextStyle(color: Colors.white)),
                                        Text(
                                          "Free",
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
                        SizedBox(height: size.height * 0.022),
                      ],
                    ),
                  );
                } else {
                  return Container(); // Return an empty container for non-matching items
                }
              },
            ),
          ),
       
        ],
      ),
    );
  }
}



// events listview builder 

// Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               scrollDirection: Axis.vertical,
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 if (_searchQuery.isEmpty || activityname[index].toLowerCase().contains(_searchQuery.toLowerCase())) {
//                   return InkWell(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) {
                    //       return CpdsSingleEventDisplay(
                    //         attendees: attendees[index],
                    //         imagelink: 'assets/cpds${index}.jpg',
                    //         cpdsname: activityname[index],
                    //       );
                    //     }),
                    //   );
                    // },
//                     child: Column(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(right: size.height * 0.009, left: size.height * 0.009),
//                           height: size.height * 0.35,
//                           width: size.width * 0.85,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(image: AssetImage("assets/cpds${index}.jpg")),
//                           ),
//                         ),
//                         SizedBox(height: size.height * 0.014),
//                         Container(
//                           height: size.height * 0.089,
//                           width: size.width * 0.7,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Color.fromARGB(255, 42, 129, 201),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 offset: Offset(0.8, 1.0),
//                                 blurRadius: 4.0,
//                                 spreadRadius: 0.2,
//                               ),
//                             ],
//                           ),
//                           child: Center(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(height: size.height * 0.008),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(left: size.width * 0.03),
//                                       child: Text(
//                                         "${activityname[index]}",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: size.height * 0.018,
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(right: size.width * 0.03),
//                                       child: Icon(
//                                         Icons.read_more,
//                                         size: size.height * 0.02,
//                                         color: Colors.white,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.white,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.calendar_month,
//                                               size: size.height * 0.02,
//                                               color: Colors.white,
//                                             ),
//                                             Text(
//                                               "Start Date",
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           "July 4, 2023, 12:00 am",
//                                           style: TextStyle(fontSize: size.height * 0.008, color: Colors.white),
//                                         ),
//                                       ],
//                                     ),
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text("Rate", style: TextStyle(color: Colors.white)),
//                                         Text(
//                                           "Free",
//                                           style: TextStyle(fontSize: size.height * 0.008, color: Colors.white),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: size.height * 0.022),
//                       ],
//                     ),
//                   );
//                 } else {
//                   return Container(); // Return an empty container for non-matching items
//                 }
//               },
//             ),
//           ),
        