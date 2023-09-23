import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ippu/Screens/ProfileScreen.dart';
import 'dart:io';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
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

 late ImageProvider _avatarImage;
 late File _selectedImage;
 TextEditingController _dateController = TextEditingController();
  FocusNode _dateFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _avatarImage = AssetImage('assets/image9.png');
 
  }


// image picker function
  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final selectedFile = File(pickedImage.path);
      setState(() {
        _selectedImage = selectedFile;
        _avatarImage = FileImage(File(pickedImage.path));

      });
    }
  }
// 



  @override
  void dispose() {
    _dateController.dispose();
    _dateFocusNode.dispose();
    super.dispose();
  }

// 

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     final userData = Provider.of<UserProvider>(context).user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:  _avatarImage,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.camera_alt, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.014),
        Text(
          '${userData!.name}',
          style: GoogleFonts.lato(
              fontSize: size.height * 0.03, fontWeight: FontWeight.bold),
        ),
        Text(
          '${userData.email}',
          style: GoogleFonts.lato(color: Colors.grey),
        ),
        SizedBox(height: size.height * 0.02),
        Divider(height: 1),
        SizedBox(height: size.height * 0.02),
        Text(
          'Complete Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 42, 129, 201),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        // a form for editing user profile to be added here
        // UserProfileForm(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.016),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                  onSaved: (value) => name = value!,
                  initialValue: userData.name,
              ),
              SizedBox(height: size.height*0.018),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gender',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                onSaved: (value) => gender = value!,
                initialValue: userData.gender,
              ),
         
              // 
              SizedBox(height: size.height*0.018),
             TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  initialValue: userData.dob, // Set the initial value
                  onSaved: (value) => dob = value!,
                  onTap: () => _selectDate(context, _dateController),
                ),
              SizedBox(height: size.height*0.018),
              TextFormField(
                decoration: InputDecoration(labelText: 'Membership Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                onSaved: (value) => membershipNumber = value!,
                initialValue: userData.membership_number,
              ),
              SizedBox(height: size.height*0.018),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                onSaved: (value) => address = value!,
                initialValue: userData.address,
              ),
              SizedBox(height: size.height*0.018),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                onSaved: (value) => phoneNo = value!,
                initialValue: userData.phone_no,
              ),
              SizedBox(height: size.height*0.018),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alternate Phone Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                onSaved: (value) => altPhoneNo = value!,
                initialValue: userData.alt_phone_no,
              ),
              SizedBox(height: size.height*0.018),
              TextFormField(
                decoration: InputDecoration(labelText: 'Next of Kin Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                onSaved: (value) => nokName = value!,
                initialValue: userData.nok_name,
              ),
              SizedBox(height: size.height*0.018),
              TextFormField(
                decoration: InputDecoration(labelText: 'Next of Kin Address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                onSaved: (value) => nokAddress = value!,
                initialValue: userData.nok_address,
              ),
              SizedBox(height: size.height*0.018),
              TextFormField(
                decoration: InputDecoration(labelText: 'Next of Kin Phone Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                onSaved: (value) => nokPhoneNo = value!,
                initialValue: userData.nok_phone_no,
              ),
              SizedBox(height: size.height*0.018),
                    ]
                  )
          )
            ],
          ),
        ),
        // form ends here
        SizedBox(height: size.height * 0.01),
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
    );
  }
 
  // ...
  // date picker function
Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    // Update the selected date in the text field
    final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
    controller.text = formattedDate;
  }
}
  // 
  
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Call the function to send data to the API
      sendUserDataToApi();
    }
  }

  void sendUserDataToApi() async {
    final userData = Provider.of<UserProvider>(context, listen:false ).user;
    final userId = userData?.id; // Replace with your actual user ID

    final apiUrl = Uri.parse('https://ippu.org/api/profile/$userId');

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
  print(userDataMap);
  print(userId);
    try {
      final response = await http.put(
        apiUrl,
        body: jsonEncode(userDataMap),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      CircleAvatar();
      if (response.statusCode == 200) {
        // Handle a successful API response
        print('Data sent successfully');
        Navigator.push(context, MaterialPageRoute(builder: ((context) => ProfileScreen() )));
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

 
 
 
