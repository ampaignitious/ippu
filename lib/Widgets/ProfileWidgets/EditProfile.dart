import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ippu/Providers/ProfilePicProvider.dart';
import 'package:ippu/Screens/ProfileScreen.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:ippu/models/UserData.dart';
import 'dart:io';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();

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
//
//
  late ImageProvider _avatarImage;

  FocusNode _dateFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _avatarImage = NetworkImage(
        Provider.of<ProfilePicProvider>(context, listen: false).profilePic);
    //set date controller from user data
    final userData = Provider.of<UserProvider>(context, listen: false).user;
    _dateController.text = userData!.dob!;
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    // Check if the widget is still mounted before updating the state
    if (!mounted) return;

    if (pickedImage != null && mounted) {
      final selectedFile = File(pickedImage.path);

      // Show a loading indicator while the image is being updated
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8),
                Text('Updating profile photo...'),
              ],
            ),
          );
        },
      );

      AuthController authController = AuthController();
      final userData = Provider.of<UserProvider>(context, listen: false).user;
      final userId = userData?.id; // Replace with your actual user ID
      final response = await authController.store(selectedFile, userId!);

      // Close the loading indicator
      Navigator.of(context).pop();

      if (response.containsKey('message')) {
        setState(() {
          final profilePicProvider = context.read<ProfilePicProvider>();
          profilePicProvider.setProfilePic(response['profile_photo_path']);
          _avatarImage = NetworkImage(
              Provider.of<ProfilePicProvider>(context, listen: false)
                  .profilePic);
        });

        Fluttertoast.showToast(
          msg: response['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to upload image',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    }
  }

  @override
  void dispose() {
    _dateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userData = Provider.of<UserProvider>(context).user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: _avatarImage,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: _pickImage,
                child: const CircleAvatar(
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
          userData!.name,
          style: GoogleFonts.lato(
              fontSize: size.height * 0.03, fontWeight: FontWeight.bold),
        ),
        Text(
          userData.email,
          style: GoogleFonts.lato(color: Colors.grey),
        ),
        SizedBox(height: size.height * 0.02),
        const Divider(height: 1),
        SizedBox(height: size.height * 0.02),
        const Text(
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
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.016),
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
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (value) {
                            name = value ?? userData.name;
                          },
                          initialValue: userData.name,
                        ),
                        SizedBox(height: size.height * 0.018),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          initialValue: userData.gender,
                          onSaved: (value) {
                            // Convert the entered value to lowercase before assigning it to 'gender'
                            gender =
                                (value ?? userData.gender)?.toLowerCase() ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }

                            // Convert the entered value to lowercase for case-insensitive comparison
                            String lowerCaseValue = value.toLowerCase();

                            // Check if the value is either "male" or "female"
                            if (lowerCaseValue != 'male' &&
                                lowerCaseValue != 'female') {
                              return 'Please enter either "male" or "female"';
                            }

                            return null;
                          },
                        ),

                        //
                        SizedBox(height: size.height * 0.018),
                        TextFormField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: 'Date of Birth',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onTap: () => _selectDate(context, _dateController),
                          onSaved: (value) {
                            dob = (_dateController.text);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field is required';
                            }

                            //check if the person is 18 years and above
                            final date = DateFormat('yyyy-MM-dd').parse(value);
                            if (!isEighteenYearsAndAbove(date)) {
                              return 'You must be 18 years and above';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.018),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Membership Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (value) {
                            membershipNumber =
                                (value ?? userData.membership_number)!;
                          },
                          initialValue: userData.membership_number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.018),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (value) {
                            address = (value ?? userData.address)!;
                          },
                          initialValue: userData.address,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.018),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (value) {
                            phoneNo = (value ?? userData.phone_no)!;
                          },
                          initialValue: userData.phone_no,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.018),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Alternate Phone Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (value) {
                            altPhoneNo = (value ?? userData.alt_phone_no)!;
                          },
                          initialValue: userData.alt_phone_no,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.018),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Next of Kin Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (value) {
                            nokName = (value ?? userData.nok_name)!;
                          },
                          initialValue: userData.nok_name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.018),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Next of Kin Address',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (value) {
                            nokAddress = (value ?? userData.nok_address)!;
                          },
                          initialValue: userData.nok_address,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.018),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Next of Kin Phone Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onSaved: (value) {
                            nokPhoneNo = (value ?? userData.nok_phone_no)!;
                          },
                          initialValue: userData.nok_phone_no,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.018),
                      ]))
            ],
          ),
        ),
        // form ends here
        SizedBox(height: size.height * 0.01),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(
                  255, 42, 129, 201), // Change button color to green
              padding: EdgeInsets.all(size.height * 0.024),
            ),
            onPressed: _submitForm,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
              child: Text(
                'update profile',
                style: GoogleFonts.lato(),
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.018),
      ],
    );
  }

  // ...
  // date picker function
  //
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // Update the selected date in the text field
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }
  //
  //

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Call the function to send data to the API
      sendUserDataToApi();
    }
  }

  void sendUserDataToApi() async {
    UserData? userData = Provider.of<UserProvider>(context, listen: false).user;
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
      'nok_email': nokAddress,
      'nok_phone_no': nokPhoneNo,
    };

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
        Provider.of<UserProvider>(context, listen: false)
            .setProfileStatus(true);
        // Handle a successful API response
        print('Data sent successfully');
        CircleAvatar();
        showBottomNotification('Profile information updated successfully');
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => ProfileScreen())));
      } else {
        // Handle errors or unsuccessful response
        showBottomNotification('Update faild, check your internet');
        print('Failed to send data to API');
      }
    } catch (error) {
      // Handle network errors or exceptions
    }
  }

  void showBottomNotification(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  //check if the person is 18 years and above
  bool isEighteenYearsAndAbove(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    final daysPerYear = 365.25;
    final years = (difference / daysPerYear).floor();
    return years >= 18;
  }
}
