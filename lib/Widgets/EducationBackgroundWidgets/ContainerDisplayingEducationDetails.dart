import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/controllers/auth_controller.dart';

class ContainerDisplayingEducationDetails extends StatefulWidget {
  const ContainerDisplayingEducationDetails({Key? key});

  @override
  State<ContainerDisplayingEducationDetails> createState() =>
      _ContainerDisplayingEducationDetailsState();
}

class _ContainerDisplayingEducationDetailsState
    extends State<ContainerDisplayingEducationDetails> {
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: authController.getEducationDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final data = snapshot.data;
            if (data != null) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];

                  return InkWell(
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.014),
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
                                            "${item['title']}",
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
                                        "Points: ${item['points']}", style: TextStyle(
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
                                  child: Text("Field: ${item['field']}", style:TextStyle(
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
                                      Text("Start date: ${item['start_date']}", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.height * 0.012,
                                      ),),
                                      Text("End date: ${item['end_date']}", style: TextStyle(
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
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.022),
                      ],
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }
}
