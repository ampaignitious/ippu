import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ippu/Screens/DefaultScreen.dart';
import 'package:ippu/Screens/IppuTermsOfUse.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/DropDownWidget.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/LoginScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ippu/Widgets/AuthenticationWidgets/RegistrationFeedback.dart';
import 'package:ippu/controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  bool _agreedToTerms = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

//
  String _selectedValue = 'Please select account type';

  List<String> _accountTypes = ['Please select account type'];

  @override
  void initState() {
    super.initState();
    _fetchAccountTypes();
  }

  Future<void> _fetchAccountTypes() async {
    final response =
        await http.get(Uri.parse('https://ippu.org/api/account-types'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData.containsKey('data')) {
        final data = jsonData['data'] as List<dynamic>;
        final accountTypeNames =
            data.map<String>((item) => item['name'].toString()).toList();

        setState(() {
          _accountTypes.addAll(accountTypeNames);
        });
      }
    } else {
      throw Exception('Failed to load account types from the API');
    }
  }

  // TextEditingController _textEditinsengiyumvawilberngController = TextEditingController();
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String mapAccountType(String selectedIndex) {
        switch (selectedIndex) {
          case 'Please select account type':
            return "0"; // Or any other default value you want
          case 'CPP (200,000)':
            return "1"; // For 'CPP (200,000)'
          case 'Student':
            return "1"; // For 'Affiliates (110,000)'
          // Add more cases as needed...
          case 'Affiliates (110,000)':
            return "3";
          case 'Graduate (150,000)':
            return "4";
          case 'Felllow (250,000)':
            return "5";
          case 'Corporate (600,000)':
            return "6";
          case 'General Memeber (1,000,000)':
            return "7";
          default:
            return "10"; // Default value for unknown selections
        }
      }

      //
      print(_selectedValue);
      final String accountTypeValue = mapAccountType(_selectedValue);

      // Prepare the data for the POST request
      final Map<String, dynamic> requestData = {
        "name": _username,
        "email": _email,
        "password": _confirmPassword,
        "account_type_id": accountTypeValue,
      };

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child:
                CircularProgressIndicator(), // You can use any loading widget you prefer
          );
        },
      );
    
     AuthController authController = AuthController();
      final response = await authController.signUp(requestData);
      // Close the loading indicator dialog
      Navigator.pop(context);
      if (!response.containsKey('error')) {
        // Registration successful, handle the response as needed.
        setState(() {
          // _email = '';
          _username = '';
          _password = '';
          _confirmPassword = '';
          _agreedToTerms = false;
          _selectedValue = 'Please select account type';
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RegistrationFeedback(email: _email);
        }));
      } else {
        // Registration failed, handle errors.
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Problem in registration, please try again!")));
      }

      //
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var _selectedValueIndex;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            Text(
              "Create account",
              style: GoogleFonts.montserrat(
                  fontSize: size.height * 0.047,
                  color: Color.fromARGB(255, 42, 129, 201),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
            Text(
              "Get your free IPPU account now. ",
              style: GoogleFonts.lato(
                color: Color.fromARGB(255, 42, 129, 201).withOpacity(0.6),
              ),
            ),
            SizedBox(
              height: size.height * 0.006,
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // You can add more validation here if needed
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    SizedBox(height: size.height * 0.018),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        // You can add more validation here if needed
                        return null;
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                    ),
                    SizedBox(height: size.height * 0.018),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          child: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    SizedBox(height: size.height * 0.018),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                          child: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: !_isConfirmPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        print('Value: $value');
                        print('_Password: $_password');
                        //   if (value != _password) {
                        // return 'Passwords do not match';
                        //   }
                        return null;
                      },
                      onSaved: (value) {
                        _confirmPassword = value!;
                      },
                    ),
                    SizedBox(height: size.height * 0.018),
                    //
                    DropdownButtonFormField<String>(
                      value: _selectedValue,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedValue = newValue!;
                        });
                      },
                      items: _accountTypes
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      decoration: InputDecoration(
                        labelText: 'Account Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    //

                    //               Row(
                    //                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Checkbox(
                    //   value: _agreedToTerms,
                    //   onChanged: (bool? value) {
                    //     setState(() {
                    //       _agreedToTerms = value!;
                    //     });
                    //   },
                    //     ),
                    //     Padding(
                    //   padding: EdgeInsets.only(left: size.width*0.04),
                    //   child: Text("By registering you agree", style: GoogleFonts.lato(
                    //     fontSize: size.height*0.015, color: Colors.black, fontWeight: FontWeight.bold
                    //   ),),
                    //     ),
                    //     InkWell(
                    //   onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context){
                    //       return IppuTermsOfUse();
                    //     }));
                    //   },
                    //   child: Padding(
                    //     padding: EdgeInsets.only(left: size.width*0.015),
                    //     child: Text("IPPU Terms of use", style: TextStyle(fontSize: size.height*0.015, color:Color.fromARGB(255, 42, 129, 201), fontWeight: FontWeight.bold),),
                    //   ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: size.height * 0.04),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 42, 129, 201), // Change button color to green
                        padding: EdgeInsets.all(size.height * 0.028),
                      ),
                      onPressed: _submitForm,
                      child: Text('Register', style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: size.height * 0.022,
                      )),
                    ),
                    SizedBox(height: size.height * 0.026),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.08),
                          child: Text(
                            "Already have an account ?",
                            style: GoogleFonts.lato(
                              fontSize: size.height * 0.022,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: size.width * 0.015),
                            child: Text(
                              "SignIn",
                              style: GoogleFonts.montserrat(
                                  fontSize: size.height * 0.022,
                                  color: Color.fromARGB(255, 42, 129, 201),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
