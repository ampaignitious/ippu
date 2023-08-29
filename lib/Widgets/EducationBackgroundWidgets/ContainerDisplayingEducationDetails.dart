import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class ContainerDisplayingEducationDetails extends StatefulWidget {
  const ContainerDisplayingEducationDetails({super.key});

  @override
  State<ContainerDisplayingEducationDetails> createState() => _ContainerDisplayingEducationDetailsState();
}

class _ContainerDisplayingEducationDetailsState extends State<ContainerDisplayingEducationDetails> {
  @override
   List universities=[
    "UCU",
    "MAK",
    "KYU",
    "MUBS",
    "KIU"
  ];
List education=[
  "BSCS (4.0)",
  "BSSE (4.23)",
  "BSCS (4.0)",
  "BSSE (4.23)",
  "BSCS (4.0)",
  "BSSE (4.23)"
];
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold( 

      body:
      ListView.builder(
    // controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: universities.length,
      itemBuilder: (context,index){
        return Stack(
            children: [
            Container(
              margin: EdgeInsets.only(left:size.width*0.03, right:size.width*0.03, top: size.height*0.012),
                height: size.height*0.195,
                width: size.width*0.98,
                decoration: BoxDecoration(
                  color: Colors.white,
                boxShadow: [
              BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Adjust shadow color and opacity
          offset: Offset(0.8, 1.0), // Adjust the shadow offset
          blurRadius: 4.0, // Adjust the blur radius
          spreadRadius: 0.2, // Adjust the spread radius
              ),
        
            ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height*0.068,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${education[index]}", style:GoogleFonts.lato(
                            fontWeight:FontWeight.bold)),
                          Text("Jul 2011 - Aug 2016")
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(left:size.width*0.47),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 42, 129, 201) ,// Change button color to green
                            padding: EdgeInsets.all(size.height * 0.004),
                          ),
                          onPressed: (){
                    
                          },
                          child: Text('Edit', style: GoogleFonts.lato(
                             
                          ),),
                        ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red ,// Change button color to green
                            padding: EdgeInsets.all(size.height * 0.004),
                          ),
                          onPressed: (){
                    
                          },
                          child: Text('Delete'),
                        ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03, top: size.height * 0.006),
                height: size.height * 0.07,
                width: size.width * 0.22,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 42, 129, 201),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0), // Circular border on top right corner
                    bottomRight: Radius.circular(20.0), // Circular border on bottom right corner
                  ),
                ),
                child: Center(child: Text('${universities[index]}', style: GoogleFonts.lato(
                  color: Colors.white
                ),)),
              )
            ],
          );},),);
  }



}



