import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/CpdsSingleEventDisplay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/SingleEventDisplay.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class ContainerDisplayingEvents extends StatefulWidget {
  const ContainerDisplayingEvents({super.key});

  @override
  State<ContainerDisplayingEvents> createState() => _ContainerDisplayingEventsState();
}

class _ContainerDisplayingEventsState extends State<ContainerDisplayingEvents> with TickerProviderStateMixin {
 

  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollVisibility);
  }

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
                labelText: 'Search Events by name',
                labelStyle: GoogleFonts.lato(
                  fontSize: size.height*0.022,
                  color: Colors.black38),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    10.0),
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
              "( Scroll to see more Events and click on the Event to see more details )",
              style: GoogleFonts.lato(
                fontSize: size.height * 0.012,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue.withOpacity(0.5),
              ),
            ),
          ),
          Divider(),
           Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: authController.getEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No data available');
                } else {
                  final data = snapshot.data;
                  if (data != null) {
                    return ListView.builder(
                      // controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        // Ensure the properties accessed here match the structure of your API response
                        final eventName = item['name'];
                        final startDate = item['start_date'];
                        final endData =item['end_date'];
                        final description = item['details'];
                        final displaypoints = item['points'];
                        final rate = item['rate'];
                        final eventId = item['id'].toString();
                        final imageLink = item['banner_name'];
                        final points= item['points'].toString();
                        if (_searchQuery.isEmpty ||
                            eventName
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              print(item);
                         Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return SingleEventDisplay(
                            id: eventId.toString(),
                            points: points.toString(),
                            rate: rate,
                            description: description,
                            startDate: startDate ,
                            endDate: endData ,
                            imagelink: 'http://app.ippu.or.ug/storage/banners/${imageLink}',
                            eventName: eventName ,
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
                                      image: NetworkImage('http://app.ippu.or.ug/storage/banners/${imageLink}'),
                                    ),
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
                                      "${item['name'].split(' ').take(2).join(' ')}", // Display only the first two words
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.height * 0.014,
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
                                          "${item['start_date']}",
                                          style: TextStyle(fontSize: size.height * 0.008, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Points", style: TextStyle(color: Colors.white)),
                                        Text(
                                          "${item['points']}",
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
