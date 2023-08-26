import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleEventDisplay extends StatefulWidget {
  String imagelink;
  String cpdsname;
  String attendees;
  SingleEventDisplay({super.key, required this.attendees, required this.cpdsname, required this.imagelink});

  @override
  State<SingleEventDisplay> createState() => _SingleEventDisplayState(this.attendees, this.cpdsname, this.imagelink);
}

class _SingleEventDisplayState extends State<SingleEventDisplay> {
  @override
  String imagelink;
  String cpdsname;
  String attendees;
  _SingleEventDisplayState(this.attendees, this.cpdsname, this.imagelink);
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("${cpdsname}", style: GoogleFonts.lato(),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                      // margin: EdgeInsets.only(right:size.height*0.009, left:size.height*0.009),
                      height: size.height*0.46,
                      width: size.width*0.84,
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   // color: Colors.white,
                        // ),
                        image: DecorationImage(image: AssetImage("${imagelink}"))
                      ),
                    ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.004),
                child: Text("Description", style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold, 
                ),),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.0008),
                child: Text("this will be about learning sessions"),
              ),
              Padding(
               padding: EdgeInsets.only(left: size.width*0.06, top: size.height*0.016),
                child: Text("Target Group", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.justify ,),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.06, right:size.width*0.06, top: size.height*0.0016),
                child: Text("CEOs, CPOs, SPOs, Procurement Managers, Officers, Assistants, Function/ Department Heads,", textAlign: TextAlign.justify,),
              ),
              SizedBox(height: size.height*0.016,),
              // container displaying the start, end rate and location
              Container(
                margin: EdgeInsets.only(left: size.width*0.03),
                height: size.height*0.08,
                width: size.width*0.96,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey,
                    offset: Offset(0.4, 0.2),
                    blurRadius: 0.2,
                    spreadRadius: 0.4,
                    )
                  ],
                ),
                child: Padding(
                  padding:EdgeInsets.only(top:size.height*0.017),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Start Date", style: TextStyle(color: Colors.green),),
                          Text("July 4, 2023, 12:00 am", style: TextStyle(fontSize: size.height*0.008),)
                        ],
                      ),
                                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("End Date", style: TextStyle(color: Colors.green),),
                          Text("July 4, 2023, 12:00 am", style: TextStyle(fontSize: size.height*0.008),)
                        ],
                      ),
                                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rate", style: TextStyle(color: Colors.red),),
                          Text("Free", style: TextStyle(fontSize: size.height*0.008),)
                        ],
                      ),
                                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location", style: TextStyle(color: Colors.red),),
                          Text("Kampale, plot 32", style: TextStyle(fontSize: size.height*0.008),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // 
              SizedBox(height: size.height*0.022,),
              // 
              Center(
                child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 50, 155, 132), // Change button color to green
                            padding: EdgeInsets.all(size.height * 0.024),

                          ),
                          onPressed: (){
                      
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width*0.12),
                            child: Text('Register to Attend', style: GoogleFonts.lato(),),
                          ),
                ),
              ),
              // 
            ],
          ),
        ),
      ),
    );
  }
}