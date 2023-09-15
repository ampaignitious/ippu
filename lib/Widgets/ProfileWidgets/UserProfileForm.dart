import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class UserProfileForm extends StatefulWidget {
  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name = '';
  String gender = '';
  String dob = '';
  String membershipNumber = '';
  String address = '';
  String phoneNo = '';
  String altPhoneNo = '';
  String nokName = '';
  String nokAddress = '';
  String nokPhoneNo = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.009),
        child: Column(
          children: <Widget>[
            // Add TextFormFields for each field
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              onSaved: (value) => name = value!,
            ),
            SizedBox(height: size.height*0.018),
            TextFormField(
              decoration: InputDecoration(labelText: 'Gender',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              onSaved: (value) => gender = value!,
            ),
            SizedBox(height: size.height*0.018),
            TextFormField(
              decoration: InputDecoration(labelText: 'Date of Birth',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              onSaved: (value) => dob = value!,
            ),
            SizedBox(height: size.height*0.018),
            TextFormField(
              decoration: InputDecoration(labelText: 'Membership Number',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              onSaved: (value) => membershipNumber = value!,
            ),
            SizedBox(height: size.height*0.018),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              onSaved: (value) => address = value!,
            ),
            SizedBox(height: size.height*0.018),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              onSaved: (value) => phoneNo = value!,
            ),
            SizedBox(height: size.height*0.018),
            TextFormField(
              decoration: InputDecoration(labelText: 'Alternate Phone Number',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              onSaved: (value) => altPhoneNo = value!,
            ),
            SizedBox(height: size.height*0.018),
            TextFormField(
              decoration: InputDecoration(labelText: 'Next of Kin Name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              onSaved: (value) => nokName = value!,
            ),
            SizedBox(height: size.height*0.018),
            TextFormField(
              decoration: InputDecoration(labelText: 'Next of Kin Address',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              onSaved: (value) => nokAddress = value!,
            ),
            SizedBox(height: size.height*0.018),
            TextFormField(
              decoration: InputDecoration(labelText: 'Next of Kin Phone Number',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              onSaved: (value) => nokPhoneNo = value!,
            ),
            SizedBox(height: size.height*0.018),
            Center(
                child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 42, 129, 201), // Change button color to green
                            padding: EdgeInsets.all(size.height * 0.024),

                          ),
                          onPressed: _submitForm,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width*0.12),
                            child: Text('update profile', style: GoogleFonts.lato(),),
                          ),
                ),
              ),
            SizedBox(height: size.height*0.018),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Call the function to send data to the API
      sendUserDataToApi();
    }
  }

  void sendUserDataToApi() async {
    final userData = Provider.of<UserProvider>(context).user;
    final userId = userData?.id; // Replace with your actual user ID

    final apiUrl = 'https://ippu.org/api/profile/$userId';

    // Create a map of the data to send
    final userDataMap = {
      'name': name,
      'gender': gender,
      'dob': dob,
      'membership_number': membershipNumber,
      'address': address,
      'phone_no': phoneNo,
      'alt_phone_no': altPhoneNo,
      'nok_name': nokName,
      'nok_address': nokAddress,
      'nok_phone_no': nokPhoneNo,
    };

    try {
      final response = await http.put(
        apiUrl as Uri,
        body: jsonEncode(userDataMap),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Handle a successful API response
        print(response);
        print('Data sent successfully');
      } else {
        // Handle errors or unsuccessful response
        print('Failed to send data to API');
      }
    } catch (error) {
      // Handle network errors or exceptions
      print('Error: $error');
    }
  }
}
