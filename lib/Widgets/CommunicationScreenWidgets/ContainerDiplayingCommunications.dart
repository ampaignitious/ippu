import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/CommunicationScreenWidgets/SingleCommunicationDisplayScreen.dart';
import 'package:ippu/controllers/auth_controller.dart';

class ContainerDisplayingCommunications extends StatefulWidget {
  const ContainerDisplayingCommunications({Key? key});

  @override
  State<ContainerDisplayingCommunications> createState() =>
      _ContainerDisplayingCommunicationsState();
}

class _ContainerDisplayingCommunicationsState
    extends State<ContainerDisplayingCommunications>
    with TickerProviderStateMixin {
  int maxWords = 40;
  final ScrollController _scrollController = ScrollController();
  AuthController authController = AuthController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollVisibility);
  }

  void _updateScrollVisibility() {
    setState(() {
      _showBackToTopButton =
          _scrollController.offset > _scrollController.position.maxScrollExtent / 2;
    });
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
      body: FutureBuilder<List<dynamic>>(
        future: authController.getAllCommunications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              // controller: _scrollController,
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return InkWell(
                  onTap: () {
                    print('$item');
                  },
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return SingleCommunicationDisplayScreen(
                          communicationtitle: item['title'],
                          communicationbody: item['message'],
                        );

                      }));
                    },
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.008),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.height * 0.009,
                          ),
                          height: size.height * 0.36,
                          width: size.width * 0.95,
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
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.06,
                                  top: size.height * 0.02,
                                ),
                                child: Text(
                                  "${item['title']}",
                                  style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    color: Color.fromARGB(255, 7, 63, 109),
                                  ),
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.066,
                                  top: size.height * 0.0025,
                                  right: size.width * 0.04,
                                  bottom: size.height * 0.008,
                                ),
                                child: Html(
                                data: shortenText(item['message'], maxWords),
                                style: {
                                  "p": Style( // Apply style to <p> tags
                                    fontSize: FontSize(size.height*0.009),
                                    color: Colors.black,
                                    // Add more style properties as needed
                                  ),
                                  "h1": Style( // Apply style to <h1> tags
                                    fontSize: FontSize(size.height*0.009),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    // Add more style properties as needed
                                  ),
                                  // Add more style definitions for other HTML elements
                                },
                              ),
                                // Text(
                                //   shortenText(item['message'], maxWords),
                                // ),
                              ),
                              Divider(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.08),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Date",
                                          style: GoogleFonts.lato(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${item['created_at']}",
                                          style: GoogleFonts.roboto(
                                            fontSize: size.height * 0.016,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(Icons.read_more),
                                        Text(
                                          "read more",
                                          style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.008)
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.03)
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  String shortenText(String text, int maxLength) {
    List<String> words = text.split(' ');
    if (words.length <= maxLength) {
      return text;
    } else {
      return words.sublist(0, maxLength).join(' ') + '...';
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
