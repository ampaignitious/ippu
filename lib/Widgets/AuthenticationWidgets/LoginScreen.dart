import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ippu/Screens/DefaultScreen.dart';
import 'package:ippu/Screens/HomeScreen.dart';
import 'package:ippu/Screens/IppuTermsOfUse.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/LoginScreen.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/RegisterScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ippu/models/UserData.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  bool _isLoginPasswordVisible = false;


  Future<void> _loginForm() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();

    //  
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // 
    // 
    final Map<String, dynamic> loginData = {
      "email": _userEmail,
      "password": _userPassword,
    };
    // 
    // 
    final response = await http.post(
      Uri.parse('http://app.ippu.or.ug/api/login'),
      body: loginData,
    );

    // Close the loading indicator dialog
    Navigator.pop(context);
    // 
    // 
    if (response.statusCode == 200) {
      // Parse the token from the response
 
        final Map<String, dynamic> responseData = json.decode(response.body);
  final String token = responseData['authorization']['token'];
  final String name = responseData['user']['name'];
  final String email = responseData['user']['email'];
print("${name}");
print('${token}');
  // Create the UserData instance
  UserData userData = UserData(
    id: responseData['user']['id'],
    name: name,
    email: email,
    token: token,
  );


  
  print(userData.email);
  Provider.of<UserProvider>(context, listen: false).setUser(userData);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
    return DefaultScreen( );
  }));

    } else {
      // Login failed, handle errors.
      print('Login failed: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid credentials, check your email and password and try again!")));

    }
    // 
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
               
                Container(
  height: size.height * 0.20,
  width: double.maxFinite,
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 42, 129, 201),
    image: DecorationImage(
      fit: BoxFit.fitWidth,
      image: AssetImage("assets/ppulogo.png"),
    ),
  ),
),
 Positioned(
  // bottom: 0,
  child:   Container(
   margin: EdgeInsets.only(top: size.height*0.18),
    height: size.height * 0.06,
  
    width: double.maxFinite,
  
    decoration: BoxDecoration(
  
      borderRadius: BorderRadius.only(
  
        topLeft: Radius.circular(15),
  
        topRight: Radius.circular(15),
  
      ),
  
      color: Colors.white,
  
    ),
  
  ),
),
              ],
            ),
            SizedBox(height: size.height*0.025,),
           Text("Login Page",style: GoogleFonts.montserrat(
            fontSize: size.height*0.047, color:Color.fromARGB(255, 42, 129, 201), fontWeight: FontWeight.bold, letterSpacing: 1)
           ),
           SizedBox(height: size.height*0.029),
           Text("Sign in to continue to IPPU Membership App", style: GoogleFonts.lato(
            color:Color.fromARGB(255, 42, 129, 201).withOpacity(0.4),
           ),),
            SizedBox(height: size.height*0.006,),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // You can add more validation here if needed
                          return null;
                        },
                        onSaved: (value) {
                          _userEmail = value!;
                        },
                      ),
                      SizedBox(height: size.height*0.028),
                      TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLoginPasswordVisible = !_isLoginPasswordVisible;
                        });
                      },
                      child: Icon(
                        _isLoginPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  obscureText: !_isLoginPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    // You can add more validation here if needed
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                ),
                     SizedBox(height: size.height*0.034),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 42, 129, 201) ,// Change button color to green
                          padding: EdgeInsets.all(size.height * 0.028),
                        ),
                        onPressed: _loginForm,
                        child: Text('Sign In'),
                      ),
                      SizedBox(height: size.height*0.026),
          Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width*0.08),
              child: Text("Don't have an account ?", style: GoogleFonts.lato(
                fontSize: size.height*0.022, color: Colors.black,
              ),),
            ),
            InkWell(
              onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                    return RegisterScreen();
                  }));},
              child: Padding(
                padding: EdgeInsets.only(left: size.width*0.015),
                child: Text("SignUp", style: GoogleFonts.montserrat(
                  fontSize: size.height*0.022, color: Color.fromARGB(255, 42, 129, 201), fontWeight: FontWeight.bold
                ),),
              ),
            ),
          ],
          ),
          Center(
            child: Padding(
                padding: EdgeInsets.only(top: size.width*0.08),
                child: Text("forgot password ?", style: GoogleFonts.lato(
                  fontSize: size.height*0.020, color: Color.fromARGB(255, 42, 129, 201).withOpacity(0.6),
                ),),
              ),
          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}