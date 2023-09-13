import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  String? eventName;
  String? eventAmount;
  String? eventId;
   PaymentScreen({super.key, this.eventAmount, this.eventName, this.eventId});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState( this.eventAmount, this.eventName, this.eventId);
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
    String? eventName;
  String? eventAmount;
  String? eventId;
_PaymentScreenState( this.eventAmount, this.eventName, this.eventId);
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
                  margin: EdgeInsets.only(right:size.height*0.009, left:size.height*0.0098, top: size.height*0.02),
                  height: size.height*0.65,
                  width: size.width*0.96,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  boxShadow: [
                BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Adjust shadow color and opacity
            offset: Offset(0.8, 1.0), // Adjust the shadow offset
            blurRadius: 4.0, // Adjust the blur radius
            spreadRadius: 0.2, // Adjust the spread radius
                )]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 
                   Container(
                    height: size.height*0.08,
                    width: size.width*0.96,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 177, 221, 241),
                    ),
                     child: Padding(
                       padding:EdgeInsets.symmetric(horizontal: size.width*0.018),
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(eventName!,
                          style: GoogleFonts.lato(
                            fontSize: size.height*0.019,
                            fontWeight:FontWeight.bold,
                          )
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel))
                        ],
                       ),
                     ),
                   ),
                  // 
                  SizedBox(height: size.height*0.005,),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: size.width*0.018),
                    child: Text("This event will cost you ${eventAmount}",
                    style: GoogleFonts.lato(

                    )
                    ),
                  ),
                  // 
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: size.width*0.022),
                    child: Text("Payment instructions",
                    style: GoogleFonts.lato(
                      
                    )
                    ),
                  ),
                  // 
                  Center(
                    child: Container(
                      height: size.height*0.35,
                      width: size.width*0.90,
                      decoration: BoxDecoration(
                        // color: Color.fromARGB(255, 177, 221, 241),
                        image: DecorationImage(image: AssetImage("assets/payment.png"))
                      ),
                     ),
                  ),
                  // 
              SizedBox(height: size.height*0.004,),
              // 
              Center(
                child:  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 42, 129, 201), // Change button color to green
                            padding: EdgeInsets.all(size.height * 0.024),

                          ),
                          onPressed: () {
                            
                      sendAttendanceRequest(eventId!);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width*0.12),
                            child: Text('Confirm Attendence', style: GoogleFonts.lato(),),
                          ),
                ), ),
           
              // 
                  ],
                ),
        )
      ),
    );
  }


  // 
  void sendAttendanceRequest(String cpdID) async {
  final userData = Provider.of<UserProvider>(context, listen: false).user;
  final userId = userData?.id; // Replace with your actual user ID

  final apiUrl = Uri.parse('http://app.ippu.or.ug/api/cpds/attend');

  // Create a map of the data to send
  final Map<String, dynamic> requestBody = {
    'user_id': userId,
    'cpd_id': cpdID,
  };

  try {
    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Handle a successful API response
      CircularProgressIndicator();
      print("Attendence registered successfully");
      showBottomNotification('Attendance for event sent successfully');
      Navigator.pop(context);
      
      // Navigator.pop(context);
    } else {
        // Handle errors or unsuccessful response
        print('Failed to send data to API');
         print('Failed to send data to API. Status code: ${response.statusCode}');
  print('Response body: ${response.body}');
      }
    } catch (error) {
      // Handle network errors or exceptions
      print('Error: $error');
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
  // 
}