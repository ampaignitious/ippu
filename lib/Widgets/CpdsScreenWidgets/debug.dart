// import 'package:flutter/material.dart';
// import 'package:ippu/Widgets/CpdsScreenWidgets/CpdsSingleEventDisplay.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:ippu/controllers/auth_controller.dart';

// class ContainerDisplayingCpds extends StatefulWidget {
//   const ContainerDisplayingCpds({super.key});

//   @override
//   State<ContainerDisplayingCpds> createState() => _ContainerDisplayingCpdsState();
// }

// class _ContainerDisplayingCpdsState extends State<ContainerDisplayingCpds> with TickerProviderStateMixin {
//   List images = [
//     "cpds1.jpg",
//     "cpds2.jpg",
//     "cpds3.jpg",
//     "cpds4.jpg",
//     "cpds3.jpg",
//     "cpds2.jpg",
//     "cpds4.jpg",
//   ];
//   List activityname = [
//     "Contract Management",
//     "Integration and implementation",
//     "Sustainable Procurement",
//     "Free CPD For all",
//     "Test ver 2",
//   ];
//   List attendees = [
//     "20",
//     "5",
//     "100",
//     "2",
//     "1",
//   ];


//   final ScrollController _scrollController = ScrollController();
 
 
//   void _scrollToTop() {
//     _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
//   }

//   bool _showBackToTopButton = false;

//   void _updateScrollVisibility() {
//     setState(() {
//       _showBackToTopButton = _scrollController.offset > _scrollController.position.maxScrollExtent / 2;
//     });
//   }

//   TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//  AuthController authController = AuthController();

//   @override
// void initState() {
//   super.initState();
//   _scrollController.addListener(_updateScrollVisibility);
// }
 
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       floatingActionButton: Visibility(
//         visible: _showBackToTopButton,
//         child: FloatingActionButton(
//           backgroundColor: Color.fromARGB(255, 42, 129, 201),
//           onPressed: _scrollToTop,
//           child: Icon(
//             Icons.arrow_upward,
//             color: Colors.white,
//           ),
//           shape: CircleBorder(),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left:size.height * 0.012, right: size.height * 0.012, top: size.height * 0.012),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.symmetric(vertical: size.height*0.004, horizontal: size.width*0.035),
//                 labelText: 'Search CPDS by name',
//                 labelStyle: GoogleFonts.lato(
//                   fontSize: size.height*0.022,
//                   color: Colors.grey),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide(color: Colors.blue),
//                 ),
//                 suffixIcon: IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _searchQuery = _searchController.text;
//                     });
//                   },
//                   icon: Icon(Icons.search),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: size.height * 0.020),
//             child: Text(
//               "( Scroll to see more CPDS and click on the CPD to see more details )",
//               style: GoogleFonts.lato(
//                 fontSize: size.height * 0.012,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black.withOpacity(0.5),
//               ),
//             ),
//           ),
//           Divider(),
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               scrollDirection: Axis.vertical,
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 if (_searchQuery.isEmpty || activityname[index].toLowerCase().contains(_searchQuery.toLowerCase())) {
//                   return InkWell(
//                     // onTap: () {
                     
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(builder: (context) {
//                     //       return CpdsSingleEventDisplay(
//                     //         attendees: attendees[index],
//                     //         imagelink: 'assets/cpds${index}.jpg',
//                     //         cpdsname: activityname[index],
//                     //       );
//                     //     }),
//                     //   );
//                     // },
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
       
//         ],
//       ),
//     );
//   }
// }



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
        


    //     ListView.builder(
    // // controller: _scrollController,
    //   scrollDirection: Axis.vertical,
    //   itemCount: 3,
    //   itemBuilder: (context,index){
    //     return Stack(
    //         children: [
    //         Container(
    //           margin: EdgeInsets.only(left:size.width*0.03, right:size.width*0.03, top: size.height*0.012),
    //             height: size.height*0.195,
    //             width: size.width*0.98,
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //             boxShadow: [
    //           BoxShadow(
    //       color: Colors.grey.withOpacity(0.5), // Adjust shadow color and opacity
    //       offset: Offset(0.8, 1.0), // Adjust the shadow offset
    //       blurRadius: 4.0, // Adjust the blur radius
    //       spreadRadius: 0.2, // Adjust the spread radius
    //           ),
        
    //         ],
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 SizedBox(height: size.height*0.068,),
    //                 Padding(
    //                   padding: EdgeInsets.symmetric(horizontal: size.width*0.06),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text("${education[index]}", style:GoogleFonts.lato(
    //                         fontWeight:FontWeight.bold)),
    //                       Text("Jul 2011 - Aug 2016")
    //                     ],
    //                   ),
    //                 ),
    //                 Divider(),
    //                 Padding(
    //                   padding: EdgeInsets.only(left:size.width*0.47),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       ElevatedButton(
    //                       style: ElevatedButton.styleFrom(
    //                         primary: Color.fromARGB(255, 42, 129, 201) ,// Change button color to green
    //                         padding: EdgeInsets.all(size.height * 0.004),
    //                       ),
    //                       onPressed: (){
                    
    //                       },
    //                       child: Text('Edit', style: GoogleFonts.lato(
                             
    //                       ),),
    //                     ),
    //                   ElevatedButton(
    //                       style: ElevatedButton.styleFrom(
    //                         primary: Colors.red ,// Change button color to green
    //                         padding: EdgeInsets.all(size.height * 0.004),
    //                       ),
    //                       onPressed: (){
                    
    //                       },
    //                       child: Text('Delete'),
    //                     ),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03, top: size.height * 0.006),
    //             height: size.height * 0.07,
    //             width: size.width * 0.22,
    //             decoration: BoxDecoration(
    //               color: Color.fromARGB(255, 42, 129, 201),
    //               borderRadius: BorderRadius.only(
    //                 topRight: Radius.circular(20.0), // Circular border on top right corner
    //                 bottomRight: Radius.circular(20.0), // Circular border on bottom right corner
    //               ),
    //             ),
    //             child: Center(child: Text('${universities[index]}', style: GoogleFonts.lato(
    //               color: Colors.white
    //             ),)),
    //           )
    //         ],
    //       );},),);
  
  // ListView.builder(
  //   // controller: _scrollController,
  //     scrollDirection: Axis.vertical,
  //     itemCount: universities.length,
  //     itemBuilder: (context,index){
  //       return Stack(
  //           children: [
  //           Container(
  //             margin: EdgeInsets.only(left:size.width*0.03, right:size.width*0.03, top: size.height*0.012),
  //               height: size.height*0.195,
  //               width: size.width*0.98,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //               boxShadow: [
  //             BoxShadow(
  //         color: Colors.grey.withOpacity(0.5), // Adjust shadow color and opacity
  //         offset: Offset(0.8, 1.0), // Adjust the shadow offset
  //         blurRadius: 4.0, // Adjust the blur radius
  //         spreadRadius: 0.2, // Adjust the spread radius
  //             ),
        
  //           ],
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(height: size.height*0.068,),
  //                   Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: size.width*0.06),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text("${education[index]}", style:GoogleFonts.lato(
  //                           fontWeight:FontWeight.bold)),
  //                         Text("Jul 2011 - Aug 2016")
  //                       ],
  //                     ),
  //                   ),
  //                   Divider(),
  //                   Padding(
  //                     padding: EdgeInsets.only(left:size.width*0.47),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           primary: Color.fromARGB(255, 42, 129, 201) ,// Change button color to green
  //                           padding: EdgeInsets.all(size.height * 0.004),
  //                         ),
  //                         onPressed: (){
                    
  //                         },
  //                         child: Text('Edit', style: GoogleFonts.lato(
                             
  //                         ),),
  //                       ),
  //                     ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           primary: Colors.red ,// Change button color to green
  //                           padding: EdgeInsets.all(size.height * 0.004),
  //                         ),
  //                         onPressed: (){
                    
  //                         },
  //                         child: Text('Delete'),
  //                       ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               margin: EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03, top: size.height * 0.006),
  //               height: size.height * 0.07,
  //               width: size.width * 0.22,
  //               decoration: BoxDecoration(
  //                 color: Color.fromARGB(255, 42, 129, 201),
  //                 borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(20.0), // Circular border on top right corner
  //                   bottomRight: Radius.circular(20.0), // Circular border on bottom right corner
  //                 ),
  //               ),
  //               child: Center(child: Text('${universities[index]}', style: GoogleFonts.lato(
  //                 color: Colors.white
  //               ),)),
  //             )
  //           ],
  //         );},)



  // ?///////

  // ListView.builder(
  //   controller: _scrollController,
  //     scrollDirection: Axis.vertical,
  //     itemCount: communications.length,
  //     itemBuilder: (context,index){
  //       return InkWell(
  //         onTap: (){
  //           Navigator.push(context, MaterialPageRoute(builder: (context){
  //             return SingleCommunicationDisplayScreen(communicationbody: communications[index], communicationtitle: communicationsheadings[index],);
  //           }));
  //         },
  //         child: Column(
  //           children: [
  //              SizedBox(height: size.height*0.008,),
  //             Container(
  //               margin: EdgeInsets.only(right:size.height*0.009, left:size.height*0.009),
  //               height: size.height*0.32,
  //               width: size.width*0.95,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //               boxShadow: [
  //             BoxShadow(
  //         color: Colors.grey.withOpacity(0.5), // Adjust shadow color and opacity
  //         offset: Offset(0.8, 1.0), // Adjust the shadow offset
  //         blurRadius: 4.0, // Adjust the blur radius
  //         spreadRadius: 0.2, // Adjust the spread radius
  //             ),
        
  //           ],
  //               ),
  //               child: Column(
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.only(left: size.width*0.02, top: size.height*0.02),
  //                     child: Text("${communicationsheadings[index]}", style: GoogleFonts.roboto(
  //                 fontSize: size.height*0.02,
  //                 fontWeight: FontWeight.bold,
  //                 fontStyle: FontStyle.normal,
  //                 color: Color.fromARGB(255, 7, 63, 109),
  //               ),)),
  //                   Divider(),
  //                   Padding(
  //                     padding: EdgeInsets.only(left: size.width*0.066, top: size.height*0.008, right: size.width*0.04, bottom: size.height*0.008,),
  //                     child: Text(
  //                       shortenText("${communications[index]}", maxWords),
  //                       ),
  //                   ),
  //                   Divider(),
  //                   Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: size.width*0.08),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                       // 
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text("Date", style: GoogleFonts.lato(
  //                               color:Colors.green,
  //                               fontWeight: FontWeight.bold
  //                             ),),
  //                             Text("July 4, 2023, 12:00 am", style: GoogleFonts.roboto(
  //                               fontSize:size.height*0.016,
  //                             ),)
  //                           ],
  //                         ),
  //                       // 
  //                       Column(
  //                         children: [
  //                           Icon(Icons.read_more),
  //                           Text("read more", style: GoogleFonts.lato(
  //                             fontWeight: FontWeight.bold,
  //                           ),),
  //                         ],
  //                       )
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(height:size.height*0.008)
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height:size.height*0.03)
  //           ],
  //         ),
  //       );
  //     }
  //   ));
  
 
// Obtained from the edit profile screen because i want to add a form

// Card(
//           margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
//           child: ListTile(
//             tileColor: Color.fromARGB(255, 212, 218, 221),
//             leading: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Name",
//                   style: GoogleFonts.lato(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text("${userData.name}"),
//               ],
//             ),
//             trailing: IconButton(
//           icon: Icon(Icons.edit),
//           onPressed: _editName, // Call the function to show the edit name dialog
//         ),
//           ),
//         ),
//         SizedBox(height: size.height * 0.02),
//         Card(
//           margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
//           child: ListTile(
//             tileColor: Color.fromARGB(255, 212, 218, 221),
//             leading: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Email",
//                   style: GoogleFonts.lato(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text("${userData.email}"),
//               ],
//             ),
//            trailing: IconButton(
//           icon: Icon(Icons.edit),
//           onPressed: _editEmail, // Call the function to show the edit name dialog
//         ),
//           ),
//         ),
//         SizedBox(height: size.height * 0.02),
//         Card(
//           margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
//           child: ListTile(
//             tileColor: Color.fromARGB(255, 212, 218, 221),
//             leading: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Password",
//                   style: GoogleFonts.lato(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text("********"),
//               ],
//             ),
//             trailing: IconButton(
//           icon: Icon(Icons.edit),
//           onPressed: _editPassword, // Call the function to show the edit name dialog
//         ),
//           ),
//         ),
        

                // container displaying the upcoming cpds in a horizontal 
        // Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Padding(
        //                     padding: EdgeInsets.only(
        //                       left: size.width * 0.06,
        //                       top: size.height * 0.02,
        //                       right: size.width * 0.06,
        //                     ),
        //                     child: Column(
        //                       children: [
        //                         Divider(),
        //                         Container(
        //                           height: size.height*0.4,
        //                           width: size.width*0.9,
        //                           child: Image_Slider()),
        //                       ],
        //                     ),
        //                   ),
        //                 ])
        // //